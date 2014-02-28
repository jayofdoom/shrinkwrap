require 'yell'

module Shrinkwrap
  module Logging
    def log
      Shrinkwrap::Logging.logger
    end
    class << self
      attr_accessor :logger
    end
  end

  # Custom logger class allows us to exit with a bang
  class Logger < Yell::Logger
    def fatal!(msg)
      self.fatal(msg)
      exit(1)
    end
  end
end
