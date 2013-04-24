module KoSpec
  module Hooks
    attr_reader :hooks

    def before(&block)
      @hooks[:before] << block
    end
  end
end
