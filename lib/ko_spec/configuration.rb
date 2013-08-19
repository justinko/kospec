module KoSpec
  class Configuration
    attr_accessor :concurrency, :locations, :pattern, :default_path

    def initialize
      self.concurrency = 5
      self.pattern = '**/*_spec.rb'
      self.default_path = 'spec'
    end

    def setup_load_path
      $LOAD_PATH.unshift(default_path) unless $LOAD_PATH.include?(default_path)
    end

    def load_spec_files
      file_paths.each {|file_path| load file_path }
    end

    private

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
