module KoSpec
  class Workers
    attr_reader :jobs

    def initialize
      @jobs = Queue.new
    end

    def prepare
      @workers = Spec.config.concurrency.times.map do
        Thread.new { @jobs.pop.run until @jobs.empty? }
      end
    end

    def work
      @workers.each &:join
    end
  end
end
