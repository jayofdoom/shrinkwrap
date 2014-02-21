# Encoding: utf-8
require 'thor'

module Shrinkwrap
  class Cli < Thor
    class_option :tmpdir,
      :type => :string,
      :default => './tmp',
      :aliases => '-t'

    class_option :verbose,
      :type => :boolean,
      :default => false,
      :aliases => '-v'

    method_option :precommand,
      :type => :string,
      :default => 'rake pre_shrinkwrap',
      :aliases => '-p'
    method_option :output_file,
      :type => :string,
      :required => true,
      :aliases => '-o'
    desc 'wrap', 'Shrinkwraps up a bundle for deployment'
    def wrap(dir)
      #TODO: Not have to set this in every separate method?
      log.level = Logger::DEBUG if options[:verbose]
      if Dir::exists?(options[:dir])
        raise(ArgumentError, "#{options[:dir]} must exist")
      end
      
      # Verify options[:dir] exists
      # Verify options[:tmpdir] exists
      Shrinkwrap::wrap.prepare_for_wrap(options[:dir], options[:precommand])
      tarball = Shrinkwrap::wrap.tar_and_compress(dir, options)
      Shrinkwrap::wrap.encrypt_and_sign(tarball, options)
    end
  end
end
