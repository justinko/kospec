module KoSpec
  class Example
    include KoSpec::Matchers

    attr_reader :description

    def initialize(group, description, &block)
      @group, @description, @block = group, description, block
    end

    def run
      Spec.reporter.example_started self
      @group.parents.push(@group).each do |group|
        group.run_hooks(:before, self)
      end
      instance_eval &@block
    end

    def assert(*args)
      run_expectation args, :PositiveHandler, caller.first
    end

    alias_method :expect, :assert

    def refute(*args)
      run_expectation args, :NegativeHandler, caller.first
    end

    private

    def run_expectation(args, handler_name, location)
      matchers = args.grep(KoSpec::Matcher)
      matchers << truthy if matchers.empty?

      matchers.each do |matcher|
        matcher.set_handler handler_name
        matcher.location = location
      end

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
