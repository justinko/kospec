require 'delegate'

module KoSpec
  class Reporter
    class Output < SimpleDelegator
      def run
        print self + "\n"
      end
    end

    class Messages
      def initialize
        @messages = Hash.new {|h, k| h[k] = []}
      end

      def for_display(example_group)
        @messages[example_group].uniq(&:location).sort.join("\n")
      end

      def add_example_group(example_group)
        @messages[example_group.root] << Message.new(example_group)
      end

      def add_example(example)
        @messages[example.root_example_group] << Message.new(example)
      end

      class Message < SimpleDelegator
        def line_number
          Integer location.split(':')[1]
        end

        def to_s
          '  ' * position + description
        end

        def <=>(other)
          line_number <=> other.line_number
        end
      end
    end

    class Counter
      def initialize
        @counter = Hash.new {|h, k| h[k] = 0}
      end

      def increment(example_group)
        @counter[example_group] += 1
      end

      def at_limit?(example_group)
        @counter[example_group] == example_group.all_examples.size
      end
    end

    def initialize
      @messages, @counter = Messages.new, Counter.new
    end

    def example_group_started(example_group)
      @messages.add_example_group example_group
    end

    def example_started(example)
    end

    def example_finished(example)
      @messages.add_example example
      example_group = example.root_example_group
      @counter.increment example_group
      Spec.mutex.synchronize do
        if @counter.at_limit?(example_group)
          output @messages.for_display(example_group)
        end
      end
    end

    def matcher_passed(matcher)
      #message '  ' * matcher.position + matcher.message
    end

    def matcher_failed(matcher)
      puts
      puts "********** Matcher failed: #{matcher.failure_message} **********"
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

    def output(str)
      Spec.workers.jobs << Output.new(str)
    end
  end
end
