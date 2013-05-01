module KoSpec
  module Mocking
    module DSL
      def mock(receiver, message)
        mocks.add Mock.new(receiver, message, caller.first)
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
        @mocks.each &:verify
      end
    end

    class Mock
      attr_reader :receiver, :message, :location, :return_value
      attr_writer :verified

      def initialize(receiver, message, location)
        @receiver, @message, @location = receiver, message, location
        @return_value, @verified = nil, false
      end

      def setup
        mock = self
        @receiver.define_singleton_method(@message) do
          mock.verified = true
          mock.return_value
        end
      end

      def verified?
        !!@verified
      end

      def verify
        if verified?
          Spec.reporter.mock_passed self
        else
          Spec.reporter.mock_failed self
        end
      end

      def returns(value)
        @return_value = value
        self
      end
    end
  end
end
