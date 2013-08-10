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

    attr_reader :parent, :children
    alias_method :example_groups, :children

    def initialize(parent, description, &block)
      @parent, @description = parent, description
      @children, @examples = [], []
      instance_eval &block
    end

    def run
      Spec.reporter.example_group_started self
      @examples.each &:run
      @children.each &:run
    end

    def it(description, &block)
      example = Example.new(self, description, &block)
      Spec.examples << example
      @examples << example
      example
    end

    alias_method :example, :it
    alias_method :specify, :it

    def parents
      ary, parent_group = [], parent
      while parent_group && Spec != parent_group
        ary.unshift parent_group
        parent_group = parent_group.parent
      end
      ary
    end

    def position
      parents.size
    end

    def description
      @description.to_s
    end
  end
end
