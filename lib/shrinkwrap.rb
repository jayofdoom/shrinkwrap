# Encoding: utf-8
require 'shrinkwrap/logger'
require 'shrinkwrap/cli'
require 'shrinkwrap/wrap'
require 'shrinkwrap/unwrap'

module Shrinkwrap
  class << self
    attr_accessor :log
  end
end

Shrinkwrap.log = Shrinkwrap::Logger.new(STDOUT)
