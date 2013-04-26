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
          "#{@matcher.actual.inspect} == #{@matcher.expected.inspect}"
        end

        def failure_message
          "#{@matcher.actual.inspect} is not equal to #{@matcher.expected.inspect}"
        end
      end

      class NegativeHandler < Handler
        def matches?
          @matcher.actual != @matcher.expected
        end

        def message
          "#{@matcher.actual.inspect} != #{@matcher.expected.inspect}"
        end

        def failure_message
          "#{@matcher.actual.inspect} is equal to #{@matcher.expected.inspect}"
        end
      end
    end
  end
end
