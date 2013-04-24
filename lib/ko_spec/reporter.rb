module KoSpec
  class Reporter
    def example_started(example)
      puts "Example started: #{example.description}"
    end

    def matcher_passed(matcher)
      puts matcher.message
    end

    def matcher_failed(matcher)
      puts matcher.failure_message
    end
  end
end
