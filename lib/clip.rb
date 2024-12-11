# frozen_string_literal: true

require_relative "clip/version"

require_relative "clip/file"

module Clip
  class Error < StandardError; end
  # Your code goes here...

  class InvalidClipFile < Error; end
end
