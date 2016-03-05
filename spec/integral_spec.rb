require "rails_helper"

module Integral
  describe "#configure" do
    let(:file_storage_type) { '' }

    before do
      Integral.configure do |config|
        config.file_storage_type = file_storage_type
      end
    end

    context 'file_storage_type' do
      context 'when setting is not set' do
        let(:file_storage_type) { '' }

        it 'ImageUploader.storage_type defaults to :file' do
          expect(ImageUploader.storage_type).to eq :file
        end
      end

      context 'when setting is :file' do
        let(:file_storage_type) { :file }

        it 'ImageUploader.storage_type returns :file' do
          expect(ImageUploader.storage_type).to eq :file
        end
      end

      context 'when setting is :fog' do
        let(:file_storage_type) { :fog }

        it 'ImageUploader.storage_type returns :fog' do
          expect(ImageUploader.storage_type).to eq :fog
        end
      end
    end
  end
end
