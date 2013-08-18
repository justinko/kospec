module KoSpec
  class Running
    include ExampleGroup::DSL
    include Hooks::DSL

    attr_reader :example_groups, :examples, :reporter, :configuration, :mutex
    alias_method :config, :configuration

    def initialize
      @example_groups, @examples = [], []
      @reporter, @threading = Reporter.new, Threading.new
      @configuration = Configuration.new
      @mutex = Mutex.new

      # will need to go in a "config" oject
      $LOAD_PATH.unshift('spec') unless $LOAD_PATH.include?('spec')
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

    def work
      @threading.queue
    end

    def start
      config.file_paths.each {|file_path| load file_path }
      example_groups.each do |example_group|
        example_group.instance_eval &example_group.block
      end
      examples.each {|example| work << example }
      @threading.setup_workers
      @threading.work
    end
  end
end
