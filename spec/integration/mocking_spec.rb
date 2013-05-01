require 'spec_helper'

Spec.describe 'mocking' do
  describe '#mock' do
    it 'works' do
      o = Object.new
      mock(o, :foo)
      o.foo
    end
  end
end
