require 'rails_helper'

module Integral
  describe "User CRUD", :type => :feature do
    let!(:user) { create(:user) }
    let(:builder) { build(:user) }

    before do
      sign_in(create(:user_manager))
      click_on 'Users'
    end

    it "can create a user" do
      click_on 'Add user'

      within("#user_form") do
        fill_in 'Name', with: builder.name
        fill_in 'Email', with: builder.email
      end

      click_on 'Invite User'

      expect(page).to have_content I18n.t('integral.backend.users.notification.creation_success')
      expect(page).to have_content builder.name
      expect(page).to have_content builder.email
    end

    it "can update a user" do
      sleep 1
      all('tbody tr.odd a')[1].trigger 'click'

      within("#user_form") do
        fill_in 'Name', with: builder.name
        fill_in 'Email', with: builder.email
      end

      click_on 'Update User'

      expect(page).to have_content I18n.t('integral.backend.users.notification.edit_success')
      expect(page).to have_content builder.name
      expect(page).to have_content builder.email
    end

    it "can delete a user" do
      sleep 1
      all('tbody tr.odd a')[2].trigger 'click'
      all('.modal-confirmation a')[0].click

      expect(page).to have_content I18n.t('integral.backend.users.notification.delete_success')
    end

    it "can view a user" do
      sleep 1
      all('tbody tr.even a')[0].trigger 'click'

      expect(page).to have_content user.name
      expect(page).to have_content user.email
    end
  end
end
