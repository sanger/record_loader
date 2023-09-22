# frozen_string_literal: true

RSpec.describe RecordLoader::Base, type: :model, loader: true do
  subject(:record_loader) do
    allow(ENV).to receive(:fetch).with('WIP', '').and_return(wip_flags)
    custom_subclass.new(**options)
  end

  let(:custom_subclass) do
    # RecordLoader::Base is not used directly, but as a subclass
    Class.new(described_class) do
      def create_or_update!(*args)
        @create_or_update_called ||= []
        @create_or_update_called << args
      end

      def create_or_update_called
        @create_or_update_called || []
      end
    end
  end

  let(:options) { { directory: test_directory, dev:, files: selected_files } }
  let(:test_directory) { "#{Pathname.pwd}/spec/data/base" }
  let(:wip_flags) { '' }

  describe '::config_folder' do
    let(:expected_folder) { Pathname.pwd.join('config/default_records/folder_name') }

    it 'provides a DSL for configuring subclasses' do
      custom_subclass.config_folder 'folder_name'
      expect(custom_subclass.config_folder).to eq 'folder_name'
    end

    it 'changes the loading directory' do
      custom_subclass.config_folder 'folder_name'
      instance = custom_subclass.new
      expect(instance.send(:default_path)).to eq(expected_folder)
    end
  end

  describe '::adapter' do
    it 'provides a DSL for configuring framework adapters' do
      custom_subclass.adapter RecordLoader::Adapter::Rails.new
      expect(custom_subclass.adapter).to be_a RecordLoader::Adapter::Rails
    end

    it 'fallbacks to a default adaptor if one is not specified' do
      expect(custom_subclass.adapter).to be_a RecordLoader::Adapter::Basic
    end
  end

  describe '#create' do
    before { record_loader.create! }

    context 'when not in the development environment' do
      let(:dev) { false }

      context 'with no files specified' do
        let(:selected_files) { nil }

        it 'calls create or update for non dev files' do
          expect(record_loader.create_or_update_called.length).to eq(4)
        end
      end

      context 'with a specific file specified' do
        let(:selected_files) { ['001_example'] }

        it 'calls create or update for the selected file files' do
          expect(record_loader.create_or_update_called.length).to eq(2)
        end
      end

      context 'with a dev file specified' do
        let(:selected_files) { ['002_example'] }

        it 'calls create or update for dev file' do
          expect(record_loader.create_or_update_called.length).to eq(2)
        end
      end

      context 'with a wip file specified' do
        let(:selected_files) { ['003_example'] }

        it 'calls create or update for dev file' do
          expect(record_loader.create_or_update_called.length).to eq(2)
        end
      end

      context 'when WIP flags are set' do
        let(:wip_flags) { '003_example,dummy_flag' }
        let(:selected_files) { nil }

        it 'calls create or update for wip file' do
          expect(record_loader.create_or_update_called.length).to eq(6)
        end
      end
    end

    context 'when in the development environment' do
      let(:options) { { directory: test_directory, dev: true } }

      it 'calls create or update for dev files in addition' do
        expect(record_loader.create_or_update_called.length).to eq(6)
      end
    end
  end

  context 'when create_or_update! raises an exception' do
    let(:dev) { true }
    let(:selected_files) { ['001_example'] }
    let(:custom_subclass) do
      # RecordLoader::Base is not used directly, but as a subclass
      Class.new(described_class) do
        def create_or_update!(*_)
          raise StandardError, 'Not good'
        end
      end
    end

    describe '#create' do
      it 'is expected to raise a more informative error message' do
        expect { record_loader.create! }.to raise_error(StandardError, 'Failed to create Example c due to: Not good')
      end
    end
  end
end
