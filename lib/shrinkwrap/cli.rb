# Encoding: utf-8
require 'thor'

module Shrinkwrap
  class Cli < Thor
    include Shrinkwrap::Logging
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
    method_option :output_prefix,
      :type => :string,
      :required => false,
      :aliases => '-o',
      :desc => 'String to prefix output file with'
    method_option :excludes,
      :type => :array,
      :required => false,
      :aliases => '-e',
      :desc => 'paths to exclude from the bundle'
    desc 'wrap', 'Shrinkwraps up a bundle for deployment'
    def initialize(*args)
      super(*args)

      Shrinkwrap::Logging.logger = Shrinkwrap::Logger.new :stdout do |l|
        l.name = 'shrinklog'
        l.level = @options[:verbose] ? :debug : :info
      end
      log.debug("Verbose logging enabled")
    end
    def wrap(dir)
      log.debug('Begin wrapping...')
      fulldir = File.expand_path(dir)
      unless Dir::exists?(fulldir)
        log.fatal!("#{fulldir} must exist")
      end

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
      log.debug('Begin unwrapping...')
      unwrapper = Shrinkwrap::Unwrap.new
    end
  end
end
