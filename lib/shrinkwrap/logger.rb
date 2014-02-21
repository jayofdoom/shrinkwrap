require 'logger'

module Shrinkwrap
  class Logger < Logger
    def fatal!(msg)
      self.fatal(msg)
      exit(1)
    end
  end
end
