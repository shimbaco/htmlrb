# frozen_string_literal: true

require "cgi/escape"

module Htmlrb
  class Tag
    # https://html.spec.whatwg.org/multipage/syntax.html#void-elements
    VOID_ELEMENTS = %w(area base br col embed hr img input link meta param source track wbr).freeze

    attr_reader :html_str

    def initialize
      @html_str = String.new
    end

    def doctype
      @html_str << "<!DOCTYPE html>"
    end

    def text(val)
      @html_str << CGI.escapeHTML(val.to_s)
    end

    def html(str)
      @html_str << str
    end

    def tag(name, options = {})
      elm_name = name.to_s.tr("_", "-")

      @html_str << "<" << elm_name

      options.each do |key, val|
        @html_str << " " << key.to_s.tr("_", "-") << '="' << CGI.escapeHTML(val.to_s) << '"'
      end

      case
      when block_given?
        @html_str << ">"
        yield self
        @html_str << "</" << elm_name << ">"
      when void_element?(elm_name)
        @html_str << " />"
      else
        @html_str << "></" << elm_name << ">"
      end
    end

    private

    def void_element?(elm_name)
      VOID_ELEMENTS.include?(elm_name)
    end
  end
end
