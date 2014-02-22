# Encoding: utf-8
require 'shrinkwrap/logger'
require 'shrinkwrap/cli'
require 'shrinkwrap/wrap'
require 'shrinkwrap/unwrap'

module Shrinkwrap
  class << self

    def log
      @@log ||= Shrinkwrap::Logger.new(STDOUT)
    end

    def runner(dir, cmd, verbose=false)
      log.info('Executing: ' + cmd + ' in ' + dir)
      Dir.chdir(dir) do
        pid, stdin, stdout, stderr = Open4::popen4(cmd)
        stdin.close
        ignored, status = Process::waitpid2 pid
        if status != 0 or verbose
          stdout.each { |out| log.info(out.chomp) }
          stderr.each { |err| log.error(err.chomp) }
          log.info(cmd + ' exited with status ' + status.to_s)
          exit 1 if status != 0
        else
          log.info(cmd + ' completed successfully!')
        end
      end
    end
  end
end
