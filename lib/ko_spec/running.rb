module KoSpec
  class Running
    include ExampleGroup::DSL
    include Hooks::DSL

    attr_reader :example_groups, :examples, :reporter

    def initialize
      @example_groups, @examples = [], []
      @reporter, @threading = Reporter.new, Threading.new

      # will need to go in a "config" oject
      $LOAD_PATH.unshift('spec') unless $LOAD_PATH.include?('spec')
    end

    def work
      @threading.queue
    end

    def start
      Dir["spec/{#{'**/*_spec.rb'}}"].sort.each do |file_path|
        load File.expand_path(file_path)
      end

      examples.each {|example| work << example }
      @threading.setup_workers
      @threading.work
    end
  end
end
