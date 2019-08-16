# frozen_string_literal: true

module Htmlrb
  class Tag
    attr_reader :html_parts

    def initialize
      @html_parts = []
    end

    def method_missing(method_name, content_or_options = "", options = {}, &block)
      options = content_or_options if content_or_options.is_a?(Hash)
      @html_parts << "<#{method_name}"

      @html_parts << " " unless options.empty?
      @html_parts << options.map do |key, val|
        "#{key}=\"#{val}\""
      end.join(" ")

      @html_parts << ">"

      if block
        @html_parts << block.call(self)
      elsif content_or_options.is_a?(String)
        @html_parts << content_or_options
      end

      if block || content_or_options.is_a?(String)
        @html_parts << "</#{method_name}>"
      end

      nil
    end
  end
end
