module KoSpec
  class ExampleGroup
    def initialize(description, &block)
      puts description
      @examples = []
      instance_eval &block
    end

    def it(description, &block)
      @examples << Example.new(description, &block)
    end

    alias_method :example, :it
    alias_method :specify, :it
  end
end
