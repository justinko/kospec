require 'thread'

module KoSpec
  class Threading
    attr_reader :queue

    def initialize
      @queue = Queue.new
    end

    def setup_workers
      @workers = 5.times.map do
        Thread.new { @queue.pop.run until @queue.empty? }
      end
    end

    def work
      @workers.each &:join
    end
  end
end
