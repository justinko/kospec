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
        sleep 1
        assert @foo
      end

      context 'when nested' do
        before { @bar = false }

        it 'works' do
          sleep 2
          assert @foo
          refute @bar
        end
      end
    end
  end
end
