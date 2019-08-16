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
end
