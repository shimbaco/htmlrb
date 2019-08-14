# frozen_string_literal: true

module Htmlrb
  class Tag
    ELEMENTS_HAVE_END_TAG = %w(a article aside audio b bdi blockquote body button code details dialog div em fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head header html i iframe label li main mark menuitem meter nav object ol option p pre progress rp rt ruby s script section select span strong summary table tbody td textarea th thead time title tr u ul video wbr).freeze
    ELEMENTS_HAVE_NO_END_TAG = %w(img input link meta).freeze

    attr_reader :str

    def initialize
      @str = ""
    end

    ELEMENTS_HAVE_END_TAG.each do |elm_name|
      define_method(elm_name) do |content_or_options, options = {}, &block|
        options = content_or_options if content_or_options.is_a?(Hash)
        @str += "<#{elm_name}"

        @str += " " unless options.empty?
        @str += options.map do |key, val|
          "#{key}=\"#{val}\""
        end.join(" ")

        @str += ">"

        if block
          block.call(self)
        else
          @str += content_or_options
        end

        @str += "</#{elm_name}>"
      end
    end
  end
end
