# frozen_string_literal: true

require "cgi/escape"

module Htmlrb
  class Tag
    # https://html.spec.whatwg.org/multipage/syntax.html#void-elements
    VOID_ELEMENTS = %w(area base br col embed hr img input link meta param source track wbr).freeze

    attr_reader :html_parts

    def initialize
      @html_parts = []
    end

    def doctype
      @html_parts << "<!DOCTYPE html>"
    end

    def text(str)
      @html_parts << CGI.escapeHTML(str)
    end

    def html(str)
      @html_parts << str
    end

    def tag(name, options = {}, &block)
      elm_name = name.to_s.gsub("_", "-")

      @html_parts << "<#{elm_name}"

      @html_parts << " " unless options.empty?
      @html_parts << options.map do |key, val|
        attr_name = key.to_s.gsub("_", "-")
        "#{attr_name}=\"#{CGI.escapeHTML(val)}\""
      end.join(" ")

      case
      when block
        @html_parts << ">"
        block.call(self)
        @html_parts << "</#{elm_name}>"
      when void_element?(elm_name)
        @html_parts << " />"
      else
        @html_parts << "></#{elm_name}>"
      end
    end

    private

    def void_element?(elm_name)
      VOID_ELEMENTS.include?(elm_name)
    end
  end
end
