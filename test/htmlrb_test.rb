require "test_helper"

class HtmlrbTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Htmlrb::VERSION
  end

  def test_it_builds_html
    actual_html = Htmlrb.build do |t|
      t.doctype
      t.html do
        t.head do
          t.title "Yuru Camp△"
        end
        t.body do
          t.a href: "http://yurucamp.jp" do
            "Official site"
          end

          t.form(method: "POST") do
            t.input(name: "name", value: "Nadeshiko")
          end
        end
      end
    end

    expected_html = %(<!DOCTYPE html><html><head><title>Yuru Camp△</title></head><body><a href="http://yurucamp.jp">Official site</a><form method="POST"><input name="name" value="Nadeshiko"></form></body></html>)

    assert_equal expected_html, actual_html
  end

  def test_it_builds_html_with_some_tag_attributes
    actual_html = Htmlrb.build do |t|
      t.a href: "http://yurucamp.jp", class: "Yuru Camp△", target: "_blank" do
        "Yuru Camp△"
      end
    end

    expected_html = %(<a href="http://yurucamp.jp" class="Yuru Camp△" target="_blank">Yuru Camp△</a>)

    assert_equal expected_html, actual_html
  end

  def test_it_builds_html_with_a_custom_tag_which_includes_underscore
    actual_html = Htmlrb.build do |t|
      t.yuru_camp data_controller: "nadeshiko"
    end

    expected_html = %(<yuru-camp data-controller="nadeshiko">)

    assert_equal expected_html, actual_html
  end

  def test_it_builds_html_with_a_custom_tag_which_includes_underscore_with_block
    actual_html = Htmlrb.build do |t|
      t.yuru_camp data_controller: "nadeshiko" do
        t.span data_target: "hello.output" do
        end
      end
    end

    expected_html = %(<yuru-camp data-controller="nadeshiko"><span data-target="hello.output"></span></yuru-camp>)

    assert_equal expected_html, actual_html
  end

  def test_it_escapes_attribute_values
    actual_html = Htmlrb.build do |t|
      t.a href: "<>" do
      end
    end

    expected_html = %(<a href="&lt;&gt;"></a>)

    assert_equal expected_html, actual_html
  end

  def test_it_escapes_text
    actual_html = Htmlrb.build do |t|
      t.a do
        "<>"
      end
    end

    expected_html = %(<a>&lt;&gt;</a>)

    assert_equal expected_html, actual_html
  end
end
