# frozen_string_literal: true

module Htmlrb
  class Tags
    ELEMENTS_HAVE_END_TAG = %w(a article aside audio b bdi blockquote body button code details dialog div em fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head header html i iframe label li main mark menuitem meter nav object ol option p pre progress rp rt ruby s script section select span strong summary table tbody td textarea th thead time title tr u ul video wbr).freeze
    ELEMENTS_HAVE_NO_END_TAG = %w(img input link meta).freeze

    ELEMENTS_HAVE_END_TAG.each do |elm_name|
      define_method(elm_name) do |*options, &block|
        puts "--- #{elm_name} called!"

        block.call(self) if block
      end
    end
  end
end
