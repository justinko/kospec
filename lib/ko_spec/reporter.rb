module KoSpec
  class Reporter
    def example_group_started(example_group)
      puts '  ' * example_group.position + example_group.description
    end

    def example_started(example)
      puts '  ' * example.position + example.description
    end

    def matcher_passed(matcher)
      puts '  ' * matcher.position + matcher.message
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
  end
end
