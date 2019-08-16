# frozen_string_literal: true

require "htmlrb/tag"

module Htmlrb
  class Builder
    def initialize
      @tag = Htmlrb::Tag.new
      yield @tag
    end

    def build
      @tag.html_parts.join
    end
  end
end
