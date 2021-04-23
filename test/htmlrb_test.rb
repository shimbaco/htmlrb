require "test_helper"

class HtmlrbTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Htmlrb::VERSION
  end

  def test_it_builds_html
    actual_html = Htmlrb.build do |h|
      h.doctype
      h.tag :html do
        h.tag :head do
          h.tag :title do
            h.text "Yuru Camp△"
          end
        end
        h.tag :body do
          h.tag :a, href: "http://yurucamp.jp" do
            h.text "Official site"
          end

          h.tag :form, method: "POST" do
            h.tag :input, name: "name", value: "Nadeshiko"
          end
        end
      end
    end

    expected_html = %(<!DOCTYPE html><html><head><title>Yuru Camp△</title></head><body><a href="http://yurucamp.jp">Official site</a><form method="POST"><input name="name" value="Nadeshiko" /></form></body></html>)

    assert_equal expected_html, actual_html
  end

  def test_it_builds_html_with_some_tag_attributes
    actual_html = Htmlrb.build do |h|
      h.tag :a, href: "http://yurucamp.jp", class: "Yuru Camp△", target: "_blank" do
        h.text "Yuru Camp△"
      end
    end

    expected_html = %(<a href="http://yurucamp.jp" class="Yuru Camp△" target="_blank">Yuru Camp△</a>)

    assert_equal expected_html, actual_html
  end

  def test_it_builds_html_with_a_custom_tag_which_includes_underscore
    actual_html = Htmlrb.build do |h|
      h.tag :yuru_camp, data_controller: "nadeshiko"
    end

    expected_html = %(<yuru-camp data-controller="nadeshiko"></yuru-camp>)

    assert_equal expected_html, actual_html
  end

  def test_it_builds_html_with_a_custom_tag_which_includes_underscore_with_block
    actual_html = Htmlrb.build do |h|
      h.tag :yuru_camp, data_controller: "nadeshiko" do
        h.tag :span, data_target: "hello.output" do
        end
      end
    end

    expected_html = %(<yuru-camp data-controller="nadeshiko"><span data-target="hello.output"></span></yuru-camp>)

    assert_equal expected_html, actual_html
  end

  def test_it_escapes_attribute_values
    actual_html = Htmlrb.build do |h|
      h.tag :a, href: "<>" do
      end
    end

    expected_html = %(<a href="&lt;&gt;"></a>)

    assert_equal expected_html, actual_html
  end

  def test_it_escapes_text
    actual_html = Htmlrb.build do |h|
      h.tag :a do
        h.text "<>"
      end
    end

    expected_html = %(<a>&lt;&gt;</a>)

    assert_equal expected_html, actual_html
  end

  def test_it_builds_html_with_a_provided_html_string
    title_html = Htmlrb.build do |h|
      h.tag :h1 do
        h.text "Nadeshiko The Cute Girl"
      end
    end

    actual_html = Htmlrb.build do |h|
      h.tag :div do
        h.html title_html
      end
    end

    expected_html = %(<div><h1>Nadeshiko The Cute Girl</h1></div>)

    assert_equal expected_html, actual_html
  end
end
