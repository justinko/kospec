module KoSpec
  module Mocking
    module DSL
      def mock(receiver, options)
        mocks.add Mock.new(receiver, options)
      end

      def mocks
        @mocks ||= Mocks.new
      end
    end

    class Mocks
      def initialize
        @mocks = []
      end

      def add(mock)
        mock.setup
        @mocks << mock
        mock
      end

      def verify
      end
    end

    class Mock
      def initialize(receiver, options)
        @receiver, @options = receiver, options
      end

      def setup
        @receiver.define_singleton_method(@options) { nil }
      end
    end
  end
end
