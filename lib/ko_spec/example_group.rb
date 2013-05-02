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

    attr_reader :parent, :description, :lets

    def initialize(parent, description, &block)
      @parent, @description, @block = parent, description, block
      @children, @examples, @lets = [], [], Lets.new
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

    def let(name, &block)
      @lets[name] = let = Let.new(block)
      define_singleton_method(name) { let.value }
      let
    end

    class Lets
      extend Forwardable

      def_delegators :@lets, :each, :[], :[]=

      def initialize
        @lets = {}
      end

      def apply(example)
        @lets.each do |name, let|
          example.define_singleton_method(name) { let.value }
        end
      end
    end

    class Let
      def initialize(block)
        @block = block
      end

      def value
        @value ||= @block.call
      end
    end
  end
end
