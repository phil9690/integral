require 'rails_helper'

module Integral
  describe Post do
    let(:post) { build(:integral_post) }

    it 'has a valid factory' do
      expect(post.valid?).to be true
    end

    describe 'relations' do
      it { is_expected.to belong_to :user }
    end

    describe 'validates' do
      it { is_expected.to validate_presence_of :title }
      it { is_expected.to validate_length_of(:title).is_at_least(4) }
      it { is_expected.to validate_length_of(:title).is_at_most(70) }
      it { is_expected.to validate_presence_of :body }
      it { is_expected.to validate_presence_of :user }
      it { is_expected.to validate_presence_of :description }
      it { is_expected.to validate_length_of(:description).is_at_least(50) }
      it { is_expected.to validate_length_of(:description).is_at_most(200) }
    end
  end
end
