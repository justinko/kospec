module KoSpec
  class Hooks
    module DSL
      def before(&block)
        hooks[:before] << block
      end

      def hooks
        @hooks ||= Hooks.new
      end
    end

    def initialize
      @hooks ||= Hash.new {|h, k| h[k] = [] }
    end

    def [](key)
      @hooks[key]
    end

    def run(type, example)
      @hooks[type].each {|hook| example.instance_eval &hook }
    end
  end
end
