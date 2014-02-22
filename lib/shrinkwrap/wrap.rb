# Encoding: utf-8
require 'open4'

module Shrinkwrap
  class Wrap
    
    def initialize(dir, options)
      @dir = dir
      @options = options
    end

    def prepare_for_wrap
      Shrinkwrap.runner(@dir, @options[:precommand], @options[:verbose])
      Shrinkwrap.log.info('Prepared ' + @dir + ' for wrapping!')
    end

    def tar_and_compress
      if @options[:output_prefix].nil?
        output_prefix = File::basename(@dir)
      else
        output_prefix = @options[:output_prefix]
      end
      # TODO: Implement in ruby instead of system calls
      # TODO: if git repo; include git sha1. For now expect it to be passed
      # in with output_prefix
      output_file = output_prefix + '.tar.gz'
      cmd = [ 
        'tar -cz',
        '-C',
        @dir,
        '-f',
        output_file,
        '.'
      ]

      cmd.push('-v') if @options[:verbose]

      unless @options[:excludes].nil?
        @options[:excludes].each do |exclude|
          cmd.push('--exclude=' + exclude)
        end
      end

      output_dir = File.expand_path('..', @dir)
      Shrinkwrap.runner(output_dir, cmd.join(' '), @options[:verbose])

      # TODO: Find a better way to pass this information around? Maybe don't 
      # even write the tarball to disk before encryption?
      @tarball = File.join(output_dir, output_file)

      unless File::exists?(@tarball)
        Shrinkwrap::log.fatal!('Cannot find created tarball at ' + @tarball)
      end
    end

    def encrypt_and_sign
      puts 'Encrypting ' + @tarball
      puts 'not really'
    end
  end
end
