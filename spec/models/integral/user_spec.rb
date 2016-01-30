require 'rails_helper'

module Integral
  describe User, type: :model do
    let(:user) { build(:user) }

    it 'has a valid factory' do
      expect(user.valid?).to be true
    end

    describe 'relations' do
    end

    describe 'validates' do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_length_of(:name).is_at_least(3) }
      it { is_expected.to validate_length_of(:name).is_at_most(25) }

      it { is_expected.to validate_presence_of :email }
    end
  end
end
