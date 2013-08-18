require 'forwardable'
require 'thread'

require 'ko_spec/configuration'
require 'ko_spec/matcher'
require 'ko_spec/matchers'
require 'ko_spec/hooks'
require 'ko_spec/mocking'
require 'ko_spec/example'
require 'ko_spec/example_group'
require 'ko_spec/option_parser'
require 'ko_spec/reporter'
require 'ko_spec/running'
require 'ko_spec/threading'

module KoSpec
  def self.running
    @running ||= Running.new
  end
end

Spec = KoSpec.running
