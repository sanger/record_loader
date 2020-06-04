# frozen_string_literal: true

require 'record_loader/filter/file_list'

RSpec.describe RecordLoader::Filter, type: :model do
  describe '::create' do
    subject { described_class.create(arguments) }

    context 'with files' do
      let(:arguments) { { files: ['test'] } }

      it { is_expected.to be_a RecordLoader::Filter::FileList }
    end

    context 'with environemnt and wip_list' do
      let(:arguments) { { dev: false, wip_list: [] } }

      it { is_expected.to be_a RecordLoader::Filter::Standard }
    end
  end
end
