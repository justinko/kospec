module KoSpec
  class Configuration
    attr_accessor :concurrency, :locations, :pattern

    def initialize
      self.concurrency = 5
      self.pattern = '**/*_spec.rb'
    end

    def file_paths
      locations.map do |location|
        if File.file?(location)
          location
        elsif File.directory?(location)
          Dir["#{location}/{#{pattern}}"]
        end
      end.flatten.uniq.map do |file_path|
        File.expand_path file_path
      end
    end
  end
end
