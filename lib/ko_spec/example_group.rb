module KoSpec
  class ExampleGroup
    module DSL
      def describe(description, &block)
        example_group = ExampleGroup.new
        example_group.description = description
        example_group.block = block
        Spec.example_groups << example_group
        example_group
      end
    end

    include DSL
    include Hooks::DSL

    attr_accessor :parent, :description, :location, :block

    def describe(*)
      example_group = super
      example_group.location = caller.first
      example_group.parent = self
      example_group
    end

    alias_method :context, :describe

    def it(description, &block)
      example = Example.new
      example.description = description
      example.location = caller.first
      example.example_group = self
      example.block = block
      Spec.examples << example
      example
    end

    alias_method :example, :it
    alias_method :specify, :it

    def ancestors
      return [] unless parent
      [parent, parent.ancestors].flatten
    end

    def descendants
      children.map {|child| [child] + child.descendants }.flatten
    end

    def children
      Spec.example_groups.select {|example_group| example_group.parent == self }
    end

    def root
      ancestors.find &:root?
    end

    def all_examples
      examples + descendants.map(&:examples).flatten
    end

    def examples
      Spec.examples.select {|example| example.example_group == self }
    end

    def root?
      position.zero?
    end

    def position
      ancestors.size
    end

    def description
      @description.to_s
    end
  end
end
