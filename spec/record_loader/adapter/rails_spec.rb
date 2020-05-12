# frozen_string_literal: true

RSpec.describe RecordLoader::Adapter::Rails, type: :model do
  subject(:adapter) { described_class.new }

  describe '#logger' do
    before do
      stub_const("::Rails", double('Rails', logger: :logger))
    end

    it 'returns the rails logger' do
      expect(adapter.logger).to eq :logger
    end
  end

  describe '#transaction' do
    before do
      stub_const("::ActiveRecord::Base", active_record_base)
    end

    let(:active_record_base) { double('::ActiveRecord::Base') }

    it 'wraps an ActiveRecord transaction' do
      expect(active_record_base).to receive(:transaction).and_yield
      expect { |b| adapter.transaction(&b) }.to yield_control
    end
  end

  describe '#development?' do
    before do
      stub_const("::Rails", double('Rails', env: environment))
    end

    let(:environment) { double('env', development?: env) }
    let(:env) { true }

    it 'returns true in development' do
      expect(adapter.development?).to be true
    end
  end
end
