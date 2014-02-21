# Encoding: utf-8
module Shrinkwrap
#      wrapper.prepare_for_wrap
#      (dir, options[:precommand])
#      tarball = wrapper.tar_and_compress
#      (dir, options)
#      wrapper.encrypt_and_sign
#      (tarball, options)
  class Wrap
    def initialize(dir, options)
      @dir = dir
      @options = options
    end

    def log
      require 'logger'
      # TODO: Share logger between classes
      @log ||= Logger.new(STDOUT)
    end

    def prepare_for_wrap
      Dir.chdir(@dir) do
        if system(@options[:precommand])
          log.info('Successfully executed ' +
                   @options[:precommand] +
                   ' in ' +
                   @dir)
        else
          # Probably want our own errorclass?
          raise SystemError, "Precommand failed #{$?}"
        end
      end

      log.info("Prepared #{@dir} for wrapping!")
    end

    def tar_and_compress
      puts 'tar and compress!'
      # options[:dir] is the dir to compress
      # should return the path to the filename it created
    end

    def encrypt_and_sign
      puts 'encrypt and signed!'
      # tarball is tarball to encrypt
      #  options[:output_file] is the final encrypted file
    end
  end
end
