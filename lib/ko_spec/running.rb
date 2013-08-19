module KoSpec
  class Running
    include ExampleGroup::DSL
    include Hooks::DSL

    attr_reader :example_groups, :examples, :reporter, :configuration, :workers, :mutex
    alias_method :config, :configuration

    def initialize
      @example_groups, @examples = [], []
      @configuration = Configuration.new
      @reporter = Reporter.new
      @workers = Workers.new
      @mutex = Mutex.new
    end

    def options=(options)
      OptionParser.new(options).parse
    end

    def describe(*)
      example_group = super
      example_group.location = caller.first
      example_group.parent = nil
      example_group
    end

    def start
      config.setup_load_path
      config.load_spec_files
      populate_examples
      enqueue_examples
      workers.prepare
      workers.work
    end

    private

    def populate_examples
      example_groups.each do |example_group|
        example_group.instance_eval &example_group.block
      end
    end

    def enqueue_examples
      examples.each {|example| workers.jobs << example }
    end
  end
end
