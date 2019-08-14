require "test_helper"

class HtmlrbTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Htmlrb::VERSION
  end

  def test_it_does_something_useful
    html = Htmlrb.build do |t|
      t.div class: "main" do
        t.span "hello"
      end
    end
  end
end
