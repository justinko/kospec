require 'optparse'

module KoSpec
  class OptionParser
    def initialize(options)
      @options = options
    end

    def parse
      Spec.config.locations = ::OptionParser.new do |o|
        o.on '-c', '--concurrency N', Integer,
             'Number of examples to run concurrently' do |concurrency|
          Spec.config.concurrency = concurrency
        end
      end.parse(@options)
    end
  end
end
