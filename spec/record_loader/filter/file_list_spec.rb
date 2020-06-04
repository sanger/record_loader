# frozen_string_literal: true

require 'record_loader/filter/file_list'

RSpec.describe RecordLoader::Filter::FileList, type: :model do
  subject(:adapter) { described_class.new(file_list) }

  let(:file_list) { %w[included_standard included_wip included_dev] }
  let(:included_standard_file) { record_file('included_standard.yml') }
  let(:included_dev_file) { record_file('included_dev.dev.yml') }
  let(:included_wip_file) { record_file('included_wip.wip.yml') }
  let(:excluded_standard_file) { record_file('excluded_standard.yml') }
  let(:excluded_dev_file) { record_file('excluded_dev.dev.yml') }
  let(:excluded_wip_file) { record_file('excluded_wip.wip.yml') }

  def record_file(name)
    RecordLoader::RecordFile.new(Pathname.new(name))
  end

  describe '#include?' do
    it { is_expected.to include included_standard_file }
    it { is_expected.to include included_dev_file }
    it { is_expected.to include included_wip_file }
    it { is_expected.not_to include excluded_standard_file }
    it { is_expected.not_to include excluded_dev_file }
    it { is_expected.not_to include excluded_wip_file }
  end
end
