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

    def prepare_for_wrap
      # TODO: Implement in ruby instead of system calls
      Dir.chdir(@dir) do
        if system(@options[:precommand])
          Shrinkwrap.log.info('Successfully executed ' +
                   @options[:precommand] +
                   ' in ' +
                   @dir)
        else
          Shrinkwrap.log.fatal!('Precommand failed: ' + $?)
        end
      end

      Shrinkwrap.log.info("Prepared #{@dir} for wrapping!")
    end

    def tar_and_compress
      unless @options[:output_prefix].empty?
        options[:output_prefix] == File::basename(@dir)
      end
      # TODO: Implement in ruby instead of system calls
      # TODO: if git repo; include git sha1. For now expect it to be passed
      # in with output_prefix
      output_file = @options[:output_prefix] + '.tar.gz'
      cmd = [ 
        'tar czf',
        output_file,
        @dir
      ]

      unless @options[:excludes].empty?
        @options[:excludes].each do |exclude|
          cmd.push('--exclude=' + exclude)
        end
      end

      Dir.chdir(File.expand_path(@dir, '..')) do
        if system(cmd.join(' '))
          Shrinkwrap.log.info('Successfully created bundle at' +
                              File::join(Dir.pwd + output_file).to_s)
        else
          Shrinkwrap.log.fatal!('Error executing: ' +
                                cmd.join(' ') +
                                ' exited with status ' +
                                $?)
        end
      end
    end

    def encrypt_and_sign
      puts 'encrypt and signed!'
      # tarball is tarball to encrypt
      #  options[:output_file] is the final encrypted file
    end
  end
end
