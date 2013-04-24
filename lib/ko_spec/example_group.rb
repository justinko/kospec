module KoSpec
  class ExampleGroup
    module DSL
      def describe(description, &block)
        example_groups << ExampleGroup.new(description, &block)
      end

      alias_method :context, :describe
    end

    include DSL
    include Hooks

    attr_reader :description

    def initialize(description, &block)
      @description, @block = description, block
      @hooks = Hash.new {|h, k| h[k] = [] }
      @children, @examples = [], []
    end

    def run
      Spec.reporter.example_group_started self
      instance_eval &@block
      @examples.each &:run
      @children.each &:run
    end

    def it(description, &block)
      @examples << Example.new(self, description, &block)
    end

    alias_method :example, :it
    alias_method :specify, :it

    def example_groups
      @children
    end
  end
end
