require 'rails_helper'

module Integral
  RSpec.describe Page, type: :model do
    let(:page) { build(:integral_page) }
    let(:acceptable_paths) { [ '/foo', '/foo/bar', '/123/456' ] }
    # TODO: Add // to unacceptable paths
    let(:unacceptable_paths) { [ 'foo', '/foo bar', '/foo?y=123', '/foo$' ] }

    it 'has a valid factory' do
      expect(page.valid?).to be true
    end

    describe 'relations' do
    end

    describe 'validates' do
      it { is_expected.to validate_presence_of :title }
      it { is_expected.to validate_length_of(:title).is_at_least(5) }
      it { is_expected.to validate_length_of(:title).is_at_most(50) }
      it { is_expected.to validate_length_of(:description).is_at_most(160) }

      it { is_expected.to validate_presence_of :path }
      it { is_expected.to validate_length_of(:path).is_at_most(100) }
      it { is_expected.to validate_uniqueness_of(:path).case_insensitive }

      it 'correct format of path' do
        acceptable_paths.each do |acceptable_path|
          expect(subject).to allow_value(acceptable_path).for(:path)
        end

        unacceptable_paths.each do |unacceptable_path|
          expect(subject).not_to allow_value(unacceptable_path).for(:path)
        end
      end
    end
  end
end
