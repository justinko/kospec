require 'spec_helper'

Spec.describe 'matchers' do
  example '#eq' do
    assert 1, eq(1)
    expect eq(1), 1
    refute 1, eq(2)
  end
end
