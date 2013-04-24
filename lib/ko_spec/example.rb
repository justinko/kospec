module KoSpec
  class Example
    include KoSpec::Matchers

    attr_reader :description

    def initialize(description, &block)
      @description = description
      KoSpec.running.reporter.example_started self
      instance_eval &block
    end

    def assert(*args)
      run_expectation args, :PositiveHandler
    end

    alias_method :expect, :assert

    def refute(*args)
      run_expectation args, :NegativeHandler
    end

    private

    def run_expectation(args, handler_name)
      matchers = args.grep(KoSpec::Matcher)
      actuals = args - matchers
      actuals.each do |actual|
        matchers.each do |matcher|
          matcher.actual = actual
          matcher.set_handler handler_name

          if matcher.matches?
            KoSpec.running.reporter.matcher_passed matcher
          else
            KoSpec.running.reporter.matcher_failed matcher
          end
        end
      end
    end
  end
end
