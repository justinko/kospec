require 'ko_spec/matcher'
require 'ko_spec/matchers'
require 'ko_spec/example'
require 'ko_spec/example_group'
require 'ko_spec/reporter'
require 'ko_spec/running'

module KoSpec
  def self.running
    @running ||= Running.new
  end

  def self.describe(description, &block)
    running.example_groups << ExampleGroup.new(description, &block)
  end
end

Spec = KoSpec
