# frozen_string_literal: true

# We don't want to add rails as a depenedency, so can't validate against the actual classes
# rubocop:disable RSpec/VerifiedDoubles
RSpec.describe RecordLoader::Adapter::Rails, type: :model do
  subject(:adapter) { described_class.new }

  describe '#logger' do
    before do
      stub_const('::Rails', double('Rails', logger: :logger))
    end

    it 'returns the rails logger' do
      expect(adapter.logger).to eq :logger
    end
  end

  describe '#transaction' do
    before do
      stub_const('::ActiveRecord::Base', active_record_base)
      allow(active_record_base).to receive(:transaction).and_yield
    end

    let(:active_record_base) { spy('::ActiveRecord::Base') }

    it 'wraps an ActiveRecord transaction' do
      expect(active_record_base).to have_recieved(:transaction)
    end

    it 'yields control' do
      expect { |b| adapter.transaction(&b) }.to yield_control
    end
  end

  describe '#development?' do
    before do
      stub_const('::Rails', double('Rails', env: environment))
    end

    let(:environment) { double('env', development?: env) }
    let(:env) { true }

    it 'returns true in development' do
      expect(adapter.development?).to be true
    end
  end
end
# rubocop:enable RSpec/VerifiedDoubles
