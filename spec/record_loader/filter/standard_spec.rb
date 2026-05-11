# frozen_string_literal: true

require 'record_loader/filter/standard'

RSpec.describe RecordLoader::Filter::Standard, type: :model do
  subject(:filter) { described_class.new(dev:, wip_list:) }

  def record_file(name)
    RecordLoader::RecordFile.new(Pathname.new(name))
  end

  let(:standard_file) { record_file('standard_file.yml') }
  let(:dev_file) { record_file('dev_file.dev.yml') }
  let(:flagged_wip_file) { record_file('in_progress.wip.yml') }
  let(:unflagged_wip_file) { record_file('inactive.wip.yml') }

  describe '#include?' do
    context 'without wip flags in a standard environment' do
      let(:dev) { false }
      let(:wip_list) { [] }

      it { is_expected.to include standard_file }
      it { is_expected.not_to include(flagged_wip_file) }
      it { is_expected.not_to include(dev_file) }
    end

    context 'with wip flags in a standard environment' do
      let(:dev) { false }
      let(:wip_list) { ['in_progress'] }

      it { is_expected.to include(standard_file) }
      it { is_expected.to include(flagged_wip_file) }
      it { is_expected.not_to include(unflagged_wip_file) }
      it { is_expected.not_to include(dev_file) }
    end

    context 'without wip flags in a dev environment' do
      let(:dev) { true }
      let(:wip_list) { [] }

      it { is_expected.to include(standard_file) }
      it { is_expected.not_to include(flagged_wip_file) }
      it { is_expected.to include(dev_file) }
    end

    context 'with wip flags in a dev environment' do
      let(:dev) { true }
      let(:wip_list) { ['in_progress'] }

      it { is_expected.to include(standard_file) }
      it { is_expected.to include(flagged_wip_file) }
      it { is_expected.not_to include(unflagged_wip_file) }
      it { is_expected.to include(dev_file) }
    end
  end
end
