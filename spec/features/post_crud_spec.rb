require 'rails_helper'

module Integral
  describe "Post CRUD", :type => :feature do
    let!(:post) { create(:integral_post) }
    let(:builder) { build(:integral_post) }

    before do
      sign_in(create(:post_manager))
      click_on 'Posts'
    end

    it "can create a post" do
      click_on 'Create post'

      within("#post_form") do
        fill_in 'Title', with: builder.title
        fill_in 'Description', with: builder.description

        fill_in_ckeditor 'post_body_editor', with: builder.body
      end

      click_on 'Create Post'

      expect(page).to have_content I18n.t('integral.backend.posts.notification.creation_success')
    end

    it "can update a post" do
      sleep 1
      all('tbody tr.odd a')[1].trigger 'click'

      within("#post_form") do
        fill_in 'Title', with: builder.title
        fill_in 'Description', with: builder.description

        fill_in_ckeditor 'post_body_editor', with: builder.body
      end

      click_on 'Update Post'

      expect(page).to have_content I18n.t('integral.backend.posts.notification.edit_success')
    end

    it "can delete a post" do
      sleep 1
      all('tbody tr.odd a')[2].trigger 'click'
      all('.modal-confirmation a')[0].click

      expect(page).to have_content I18n.t('integral.backend.posts.notification.delete_success')
    end

    # it "can view a post" do
    #   sleep 1
    #   all('tbody tr.odd a')[0].trigger 'click'
    #
    #   expect(page).to have_content post.title
    # end
  end
end
