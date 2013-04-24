module KoSpec
  module Matchers
    def eq(expected)
      Eq.new(expected)
    end

    class Eq < Matcher
      class PositiveHandler < Handler
        def matches?
          @matcher.actual == @matcher.expected
        end

        def message
          "#{@matcher.actual} == #{@matcher.expected}"
        end

        def failure_message
          "#{@matcher.actual} is not equal to #{@matcher.expected}"
        end
      end

      class NegativeHandler < Handler
        def matches?
          @matcher.actual != @matcher.expected
        end

        def message
          "#{@matcher.actual} != #{@matcher.expected}"
        end

        def failure_message
          "#{@matcher.actual} is equal to #{@matcher.expected}"
        end
      end
    end
  end
end
