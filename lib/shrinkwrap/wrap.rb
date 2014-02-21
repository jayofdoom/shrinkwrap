# Encoding: utf-8
module Shrinkwrap
  class Wrap
    def prepare_for_wrap(dir,precommand)
      Dir.chdir(dir){
          if system(options[:precommand])
            log.info('Successfully executed ' +
                     options[:precommand] +
                     ' in ' +
                     options[:dir])
          else
            # Probably want our own errorclass?
            raise SystemError, "Precommand failed #{$?}"
          end
      }

      puts "Prepared for wrapping!"
      # run precommand
      # verify success
      # what should this return?
    end

    def tar_and_compress(dir,options)
      # options[:dir] is the dir to compress
      # should return the path to the filename it created
    end

    def encrypt_and_sign(tarball,options)
      # tarball is tarball to encrypt
      #  options[:output_file] is the final encrypted file
    end
  end
end
