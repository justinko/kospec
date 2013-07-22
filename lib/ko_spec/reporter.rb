module KoSpec
  class Reporter
    def initialize
      @queue = Queue.new
    end

    def work
      @workers = 2.times.map do
        Thread.new do
          puts @queue.size
          puts @queue.pop until @queue.empty?
        end
      end
      @workers.each &:join
    end

    def example_group_started(example_group)
      @queue << '  ' * example_group.position + example_group.description
    end

    def example_started(example)
      @queue << '  ' * example.position + example.description
    end

    def matcher_passed(matcher)
      @queue << '  ' * matcher.position + matcher.message
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
