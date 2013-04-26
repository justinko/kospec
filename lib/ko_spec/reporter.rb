module KoSpec
  class Reporter
    def example_group_started(example_group)
      puts "Example group started: #{example_group.description}"
    end

    def example_started(example)
      puts "Example started: #{example.description}"
    end

    def matcher_passed(matcher)
      puts matcher.message
    end

    def matcher_failed(matcher)
      puts "********** #{matcher.failure_message} **********"
    end
  end
end
