module KoSpec
  class Running
    attr_reader :example_groups, :reporter

    def initialize
      @example_groups = []
      @reporter = Reporter.new
    end

    def start
      Dir["spec/{#{'**/*_spec.rb'}}"].sort.each do |file_path|
        load File.expand_path(file_path)
      end
    end
  end
end
