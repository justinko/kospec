require 'spec_helper'

Spec.describe 'matchers' do
  example '#eq' do
    assert 1, eq(1)
    expect eq(1), 1
    refute 1, eq(2)
  end

  example '#error' do
    expect error(RuntimeError.new) do
      raise RuntimeError
    end
    expect exception(StandardError.new('foo')) do
      raise StandardError, 'foo'
    end
    refute error(RuntimeError.new) do
      raise StandardError
    end
    refute error(RuntimeError.new('foo')) do
      raise RuntimeError, 'bar'
    end
    refute error(RuntimeError.new) { }
  end
end
