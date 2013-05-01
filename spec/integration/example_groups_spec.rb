require 'spec_helper'

Spec.describe 'example groups' do
  describe 'a group' do
    it 'can be nested' do
      assert true
    end
  end

  describe '#let' do
    let(:object) { Object.new }

    it 'works' do
      assert object, equal(object)
    end

    describe 'nested' do
      it 'works' do
        assert object
      end
    end

    describe 'overridden' do
      let(:object) { 1 }

      it 'works' do
        assert object, eq(1)
      end
    end
  end

  describe 'hooks' do
    describe '#before' do
      before { @foo = true }

      it 'works' do
        assert @foo
      end

      context 'when nested' do
        before { @bar = false }

        it 'works' do
          assert @foo
          refute @bar
        end
      end
    end
  end
end
