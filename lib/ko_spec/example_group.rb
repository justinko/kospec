module KoSpec
  class ExampleGroup
    module DSL
      def describe(description, &block)
        example_group = ExampleGroup.new(self, description, &block)
        example_groups << example_group
        example_group
      end

      alias_method :context, :describe
    end

    include DSL
    include Hooks::DSL

    attr_reader :parent, :description

    def initialize(parent, description, &block)
      @parent, @description, @block = parent, description, block
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

    def example_groups() @children end

    def parents
      ary, parent_group = [], parent
      while parent_group
        ary.unshift parent_group
        parent_group = parent_group.parent
      end
      ary
    end
  end
end
