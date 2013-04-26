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

        def message(term = 'truthy')
          "#{@matcher.actual.inspect} is #{term}"
        end

        def failure_message(term = 'falsey')
          "#{@matcher.actual.inspect} is #{term}"
        end
      end

      class NegativeHandler < PositiveHandler
        def matches?
          not super
        end

        def message
          super 'falsey'
        end

        def failure_message
          super 'truthy'
        end
      end
    end
  end
end
