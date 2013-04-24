module KoSpec
  module Matchers
    def falsey
      Falsey.new
    end

    class Falsey < Matcher
      def initialize; end

      class PositiveHandler < Handler
        def matches?
          !@matcher.actual
        end

        def message
          "#{@matcher.actual} is falsey"
        end

        def failure_message
          "#{@matcher.actual} is truthy"
        end
      end

      class NegativeHandler < Handler
        def matches?
          !!@matcher.actual
        end

        def message
          "#{@matcher.actual} is truthy"
        end

        def failure_message
          "#{@matcher.actual} is falsey"
        end
      end
    end
  end
end
