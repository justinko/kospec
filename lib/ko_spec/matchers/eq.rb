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

        def message(separator = '==')
          "#{@matcher.actual.inspect} #{separator} #{@matcher.expected.inspect}"
        end

        def failure_message(separator = 'is not')
          "#{@matcher.actual.inspect} #{separator} equal to #{@matcher.expected.inspect}"
        end
      end

      class NegativeHandler < PositiveHandler
        def matches?
          not super
        end

        def message
          super '!='
        end

        def failure_message
          super 'is'
        end
      end
    end
  end
end
