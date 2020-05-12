# frozen_string_literal: true

RSpec.describe RecordLoader::Adapter::Basic, type: :model do
  subject(:adapter) { described_class.new }

  describe '#logger' do
    it 'returns the rails logger' do
      expect(adapter.logger).to be_a Logger
    end
  end

  describe '#transaction' do
    it 'yeilds control' do
      expect { |b| adapter.transaction(&b) }.to yield_control
    end
  end

  describe '#development?' do
    subject { adapter.development? }

    before { allow(ENV).to receive(:fetch).with('RACK_ENV', 'unknown').and_return(env) }

    context 'when not development' do
      let(:env) { 'not dev' }

      it { is_expected.to be false }
    end

    context 'when development' do
      let(:env) { 'development' }

      it { is_expected.to be true }
    end
  end
end
