# frozen_string_literal: true

require "htmlrb/builder"
require "htmlrb/version"

module Htmlrb
  class Error < StandardError; end

  def self.build
    Builder.new do |b|
      yield b
    end
  end
end
