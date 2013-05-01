# KoSpec

A Ruby Testing Framework

## Highlights

* No methods/pollution on `Object`
* Matchers are shared between expectations and mocks
* Concise non-wordy expectations
* One gem/library
* Option to fail-fast or not (per example, à la Jasmine)
* Power of the matcher!

## Installation

Add this line to your application's Gemfile:

    gem 'kospec'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kospec

## Usage

```
Spec.describe 'kospec' do
  it 'is awesome' do
    assert 5, eq(5)
    assert eq(5), 5 # argument order don't matter!
    expect 5, 5 # I know ya'll love your aliases
    refute 'foo', eq('bar') # Y U SO NEGATIVE?
    assert 5, greater_than(4), message('5 is greater than 4 you scoundrel') # ad hoc messages

    assert error(RuntimeError.new) do
      raise RuntimeError
    end

    assert 1, 2, 3, less_than(5) # matcher applied to each "actual" (1,2,3)
  end
end
```

### Mocking

```
Spec.describe 'mocks' do
  it 'is awesome' do
    object = Object.new
    mock(object, :a_message)
    mock(object, :a_message).returns(true)
    mock(object, :a_message).with(kind_of(MyClass)).once

    stub(object, :foo).raises(MyError, 'an error message')

    double('foo') do |foo|
      mock(foo, :bar).returns(5)
      stub(foo, :baz)
    end
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
