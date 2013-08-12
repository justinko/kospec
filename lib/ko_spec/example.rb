module KoSpec
  class Example
    include Matchers
    include Mocking::DSL

    attr_accessor :example_group, :description, :location, :block

    def initialize
      @expectations = []
    end

    def run
      Spec.reporter.example_started self
      example_groups.each do |example_group|
        Spec.reporter.example_group_started example_group
        example_group.hooks.run :before, self
      end
      instance_eval &@block
      mocks.verify
      Spec.reporter.example_finished self
    end

    def root_example_group
      example_groups.find &:root?
    end

    def example_groups
      @example_group.ancestors + [@example_group]
    end

    def position
      @example_group.position.next
    end

    def assert(*args, &block)
      expectation = Expectation.new(self)
      expectation.handler_name = :PositiveHandler
      expectation.location = caller.first
      expectation.args = args
      expectation.block = block
      expectation.run
      @expectations << expectation
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
      @expectations << expectation
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

        if matchers.empty?
          if args.size > 1
            matchers << eq(args.pop)
          else
            matchers << truthy unless args.all? {|arg| Proc === arg }
          end
        end

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
