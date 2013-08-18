module KoSpec
  class Threading
    attr_reader :queue

    def initialize
      @queue = Queue.new
    end

    def setup_workers
      @workers = Spec.config.concurrency.times.map do
        Thread.new { @queue.pop.run until @queue.empty? }
      end
    end

    def work
      @workers.each &:join
    end
  end
end
