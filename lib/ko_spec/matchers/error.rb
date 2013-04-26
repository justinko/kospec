module KoSpec
  module Matchers
    def error(expected)
      Error.new(expected)
    end

    alias_method :exception, :error

    class Error < Matcher
      class PositiveHandler < Handler
        def matches?
          @matcher.actual.call
        rescue Exception => @actual_error
          @matcher.expected.class === @actual_error &&
          @matcher.expected.message == @actual_error.message
        end

        def message
          "raised #{@actual_error.inspect}"
        end

        def failure_message
          "expected #{@matcher.expected.inspect}, but raised #{@actual_error.inspect}"
        end
      end

      class NegativeHandler < PositiveHandler
        def matches?
          not super
        end

        def message
          "did not raise #{@matcher.expected.inspect}"
        end

        def failure_message
          "expected to not raise #{@actual_error.inspect}"
        end
      end
    end
  end
end
