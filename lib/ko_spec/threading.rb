require 'thread'

module KoSpec
  class Threading
    attr_reader :queue

    def initialize
      @queue = Queue.new
    end

    def setup_workers
      @workers = 2.times.map { Thread.new { work } }
    end

    def run_examples
      @workers.each &:join
    end

    private

    def work
      @queue.pop.run until @queue.empty?
    end
  end
end
