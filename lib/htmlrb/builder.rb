# frozen_string_literal: true

require "htmlrb/tags"

module Htmlrb
  class Builder
    def initialize
      yield Htmlrb::Tags.new
    end
  end
end
