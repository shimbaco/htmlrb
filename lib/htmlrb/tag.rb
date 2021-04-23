require "cgi/escape"

module Htmlrb
  class Tag
    # https://html.spec.whatwg.org/multipage/syntax.html#void-elements
    VOID_ELEMENTS = %w(area base br col embed hr img input link meta param source track wbr).freeze

    attr_reader :html_str

    def initialize
      @html_str = ""
    end

    def doctype
      @html_str << "<!DOCTYPE html>"
    end

    def text(str)
      @html_str << CGI.escapeHTML(str)
    end

    def html(str)
      @html_str << str
    end

    def tag(name, options = {}, &block)
      elm_name = name.to_s.gsub("_", "-")

      @html_str << "<#{elm_name}"

      @html_str << " " unless options.empty?
      @html_str << options.map do |key, val|
        attr_name = key.to_s.gsub("_", "-")
        "#{attr_name}=\"#{CGI.escapeHTML(val)}\""
      end.join(" ")

      case
      when block
        @html_str << ">"
        block.call(self)
        @html_str << "</#{elm_name}>"
      when void_element?(elm_name)
        @html_str << " />"
      else
        @html_str << "></#{elm_name}>"
      end
    end

    private

    def void_element?(elm_name)
      VOID_ELEMENTS.include?(elm_name)
    end
  end
end
