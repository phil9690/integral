require 'rails_helper'
require 'carrierwave/test/matchers'

module Integral
  describe ImageUploader do
    include CarrierWave::Test::Matchers

    describe '#extension_white_list' do
      it 'has the correct whitelisted file formats' do
        expect(subject.extension_white_list).to eq ["jpg", "jpeg", "gif", "png"]
      end
    end

    describe '#store_dir' do
      let(:model) { create(:user) }
      let(:mounted_as) { 'avatar' }

      it 'has the correct storage directory' do
        expect(described_class.new(model, mounted_as).store_dir).to eq "uploads/integral/user/#{mounted_as}/#{model.id}"
      end
    end
  end
end
