module KoSpec
  module Hooks
    def before(&block)
      hooks[:before] << block
    end

    def run_hooks(type, example)
      hooks[type].each {|hook| example.instance_eval &hook }
    end

    def hooks
      @hooks ||= Hash.new {|h, k| h[k] = [] }
    end
  end
end
