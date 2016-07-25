require 'rails_helper'

module Integral
  describe "Page CRUD", :type => :feature do
    let!(:integral_page) { create(:integral_page) }
    let(:builder) { build(:integral_page) }

    before do
      sign_in(create(:page_manager))
      click_on 'Pages'
    end

    it "can create a page" do
      click_on 'Add page'

      within("#page_form") do
        fill_in 'Title', with: builder.title
        fill_in 'Description', with: builder.description
        fill_in 'Path', with: builder.path

        fill_in_ckeditor 'content_editor', with: builder.body
      end

      click_on 'Create Page'

      expect(page).to have_content I18n.t('integral.pages.notification.creation_success')
    end

    it "can update a page" do
      sleep 1
      all('tbody tr.odd a')[1].trigger 'click'

      within("#page_form") do
        fill_in 'Title', with: builder.title
        fill_in 'Description', with: builder.description
        fill_in 'Path', with: builder.path

        fill_in_ckeditor 'content_editor', with: builder.body
      end

      click_on 'Update Page'

      expect(page).to have_content I18n.t('integral.pages.notification.edit_success')
    end

    it "can delete a page" do
      sleep 1
      all('tbody tr.odd a')[2].trigger 'click'
      all('.modal-confirmation a')[0].click

      expect(page).to have_content I18n.t('integral.pages.notification.delete_success')
    end

    # it "can view a page" do
    #   sleep 1
    #   all('tbody tr.odd a')[0].trigger 'click'
    #
    #   expect(page).to have_content page.title
    # end
  end
end
