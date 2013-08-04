require 'delegate'

module KoSpec
  class Reporter
    class Message < SimpleDelegator
      def run
        print self + "\n"
      end
    end

    def example_group_started(example_group)
      message '  ' * example_group.position + example_group.description
    end

    def example_started(example)
      message '  ' * example.position + example.description
    end

    def matcher_passed(matcher)
      message '  ' * matcher.position + matcher.message
    end

    def matcher_failed(matcher)
      puts
      puts "********** #{matcher.failure_message} **********"
      puts matcher.location
      puts
    end

    def mock_passed(mock)
      #puts "Mock passed: `#{mock.message}` called on #{mock.receiver}"
    end

    def mock_failed(mock)
      puts
      puts "****** Mock failed: `#{mock.message}` not called on #{mock.receiver} ******"
      puts mock.location
      puts
    end

    private

    def message(str)
      Spec.work << Message.new(str)
    end
  end
end
