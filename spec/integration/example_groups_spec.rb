require 'spec_helper'

Spec.describe 'example groups' do
  describe 'a group' do
    it 'can be nested' do
      assert true
    end
  end

  describe 'hooks' do
    describe '#before' do
      before { @foo = true }

      it 'works' do
        puts 'foo'
        puts @foo.inspect
        assert @foo
      end

      context 'when nested' do
        before { @bar = false }

        it 'works' do
          puts 'bar'
          puts @foo.inspect
          puts @bar.inspect
          refute @bar
        end
      end
    end
  end
end
