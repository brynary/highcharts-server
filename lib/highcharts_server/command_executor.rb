require "posix/spawn"

module HighchartsServer
  class CommandExecutor
    TIMEOUT = 30 # 30 seconds

    class Failure < StandardError
    end

    def initialize(options = {})
      @options = default_options.merge(options)
    end

    def run!(*args)
      options = @options.merge(args.extract_options!)
      child = POSIX::Spawn::Child.new(*(args + [options]))

      raise Failure.new(child.err) unless child.success?
    end

  private

    def default_options
      { :timeout => TIMEOUT }
    end

  end
end
