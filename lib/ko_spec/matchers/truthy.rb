module KoSpec
  module Matchers
    def truthy
      Truthy.new
    end

    class Truthy < Matcher
      def initialize() end

      class PositiveHandler < Handler
        def matches?
          !!@matcher.actual
        end

        def message
          "#{@matcher.actual.inspect} is truthy"
        end

        def failure_message
          "#{@matcher.actual.inspect} is falsey"
        end
      end

      class NegativeHandler < Handler
        def matches?
          !@matcher.actual
        end

        def message
          "#{@matcher.actual.inspect} is falsey"
        end

        def failure_message
          "#{@matcher.actual.inspect} is truthy"
        end
      end
    end
  end
end
