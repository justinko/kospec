module KoSpec
  class Example
    include KoSpec::Matchers

    attr_reader :description

    def initialize(group, description, &block)
      @group, @description, @block = group, description, block
    end

    def run
      Spec.reporter.example_started self
      @group.hooks[:before].each do |hook|
        instance_eval &hook
      end
      instance_eval &@block
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

      if matchers.empty?
        matchers << truthy if handler_name == :PositiveHandler
        matchers << falsey if handler_name == :NegativeHandler
      end

      matchers.each {|matcher| matcher.set_handler handler_name }

      actuals = args - matchers
      actuals.each do |actual|
        matchers.each do |matcher|
          matcher.actual = actual

          if matcher.matches?
            Spec.reporter.matcher_passed matcher
          else
            Spec.reporter.matcher_failed matcher
          end
        end
      end
    end
  end
end
