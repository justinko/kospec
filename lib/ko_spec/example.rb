module KoSpec
  class Example
    include Matchers
    include Mocking::DSL

    attr_reader :description

    def initialize(group, description, &block)
      @group, @description, @block = group, description, block
    end

    def run
      Spec.reporter.example_started self
      @group.parents.push(@group).each do |group|
        group.hooks.run(:before, self)
      end
      instance_eval &@block
      mocks.verify
    end

    def position
      @group.position.next
    end

    def assert(*args, &block)
      expectation = Expectation.new(self)
      expectation.handler_name = :PositiveHandler
      expectation.location = caller.first
      expectation.args = args
      expectation.block = block
      expectation.run
      expectation
    end

    alias_method :expect, :assert

    def refute(*args, &block)
      expectation = Expectation.new(self)
      expectation.handler_name = :NegativeHandler
      expectation.location = caller.first
      expectation.args = args
      expectation.block = block
      expectation.run
      expectation
    end

    class Expectation
      include Matchers

      attr_accessor :args, :block, :handler_name, :location

      def initialize(example)
        @example = example
      end

      def position
        @example.position.next
      end

      def run
        matchers = args.grep(Matcher)
        matchers << truthy if matchers.empty?

        matchers.each do |matcher|
          matcher.handler = handler_name
          matcher.expectation = self
        end

        actuals = args - matchers
        actuals << block if actuals.empty?

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
end
