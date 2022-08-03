# frozen_string_literal: true

require 'record_loader/attribute'

RSpec.describe RecordLoader::Attribute, type: :model, loader: true do
  subject(:attribute) do
    described_class.new(name, type, default)
  end

  let(:name) { 'example' }

  context 'when a string' do
    let(:type) { :string }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to be_a String }
      end

      context 'with a default' do
        let(:default) { 'default' }

        it { is_expected.to eq default }
      end
    end
  end

  context 'when a text' do
    let(:type) { :text }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to be_a String }
      end

      context 'with a default' do
        let(:default) { 'Default' }

        it { is_expected.to eq default }
      end
    end
  end

  context 'when a integer' do
    let(:type) { :integer }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to be_a Integer }
      end

      context 'with a default' do
        let(:default) { 1 }

        it { is_expected.to eq default }
      end
    end
  end

  context 'when a float' do
    let(:type) { :float }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to be_a Float }
      end

      context 'with a default' do
        let(:default) { 1.0 }

        it { is_expected.to eq default }
      end
    end
  end

  context 'when a decimal' do
    let(:type) { :decimal }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to be_a Float }
      end

      context 'with a default' do
        let(:default) { 1.0 }

        it { is_expected.to eq default }
      end
    end
  end

  context 'when a datetime' do
    let(:type) { :datetime }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to be_a Time }
      end

      context 'with a default' do
        let(:default) { Time.new }

        it { is_expected.to eq default }
      end
    end
  end

  context 'when a timestamp' do
    let(:type) { :timestamp }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to be_a Time }
      end

      context 'with a default' do
        let(:default) { Time.new }

        it { is_expected.to eq default }
      end
    end
  end

  context 'when a date' do
    let(:type) { :date }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to be_a Date }
      end

      context 'with a default' do
        let(:default) { 1 }

        it { is_expected.to eq default }
      end
    end
  end

  context 'when a boolean' do
    let(:type) { :boolean }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to eq false }
      end

      context 'with a default' do
        let(:default) { true }

        it { is_expected.to eq true }
      end
    end
  end

  context 'when a json' do
    let(:type) { :json }

    describe '#value' do
      subject { attribute.value(1) }

      context 'without a default' do
        let(:default) { nil }

        it { is_expected.to eq({}) }
      end

      context 'with a default' do
        let(:default) { { 'hello' => 'world' } }

        it { is_expected.to eq default }
      end
    end
  end
end
