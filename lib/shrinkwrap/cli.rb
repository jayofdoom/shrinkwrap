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
      fulldir = File.expand_path(dir)
      unless Dir::exists?(fulldir)
        raise(ArgumentError, "#{fulldir} must exist")
      end
      
      # Verify options[:dir] exists
      # Verify options[:tmpdir] exists
      wrapper = Shrinkwrap::Wrap.new(fulldir, options)
      wrapper.prepare_for_wrap
      wrapper.tar_and_compress
      wrapper.encrypt_and_sign
    end

    method_option :postcommand,
      :type => :string,
      :default => './unwrap.sh',
      :aliases => '-p',
      :required => false
    desc 'unwrap', 'Unwraps a deployment bundle'
    def unwrap(bundle)
      #TODO: everything
      puts 'unwrapped'
    end
  end
end
