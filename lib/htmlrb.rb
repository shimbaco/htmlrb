# frozen_string_literal: true

require "htmlrb/builder"
require "htmlrb/version"

module Htmlrb
  def self.build
    builder = Builder.new do |bldr|
      yield bldr
    end

    builder.build
  end
end
