module KoSpec
  class Running
    include ExampleGroup::DSL
    include Hooks::DSL

    attr_reader :example_groups, :reporter, :lets

    def initialize
      @example_groups, @reporter = [], Reporter.new
      @lets = ExampleGroup::Lets.new
    end

    def start
      Dir["spec/{#{'**/*_spec.rb'}}"].sort.each do |file_path|
        load File.expand_path(file_path)
      end

      example_groups.each &:run
    end

    def parent() nil end
  end
end
