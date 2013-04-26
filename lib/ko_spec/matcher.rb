require 'forwardable'

module KoSpec
  class Matcher
    extend Forwardable

    attr_accessor :actual, :location
    attr_reader :expected

    def_delegators :@handler, :matches?, :message, :failure_message

    def initialize(expected)
      @expected = expected
    end

    def set_handler(handler_name)
      @handler = self.class.const_get(handler_name, false).new(self)
    end

    class Handler
      def initialize(matcher)
        @matcher = matcher
      end
    end
  end
end
