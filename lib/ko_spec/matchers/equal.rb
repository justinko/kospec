module KoSpec
  module Matchers
    def equal(expected)
      Equal.new(expected)
    end

    class Equal < Matcher
      class PositiveHandler < Handler
        def matches?
          @matcher.actual.equal? @matcher.expected
        end

        def message(separator = 'is')
          "#{@matcher.actual.inspect} #{separator} `equal?` to #{@matcher.expected.inspect}"
        end

        def failure_message(separator = 'is not')
          "#{@matcher.actual.inspect} #{separator} `equal?` to #{@matcher.expected.inspect}"
        end
      end

      class NegativeHandler < PositiveHandler
        def matches?
          not super
        end

        def message
          super 'is not'
        end

        def failure_message
          super 'is'
        end
      end
    end
  end
end
