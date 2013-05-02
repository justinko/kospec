require 'forwardable'

require 'ko_spec/matcher'
require 'ko_spec/matchers'
require 'ko_spec/hooks'
require 'ko_spec/mocking'
require 'ko_spec/example'
require 'ko_spec/example_group'
require 'ko_spec/reporter'
require 'ko_spec/running'

module KoSpec
  def self.running
    @running ||= Running.new
  end
end

Spec = KoSpec.running
