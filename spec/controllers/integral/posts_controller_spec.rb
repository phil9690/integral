require 'rails_helper'

module Integral
  describe PostsController do
    routes { Integral::Engine.routes }

    let(:title) { 'foobar title' }
    let(:slug) { 'foobar-title' }
    let(:body) { 'foobar body.' }
    let(:description) { Faker::Lorem.paragraph(8)[0..150] }
    let(:tag_list) { 'foo,bar,tags' }
    let(:post_params) { { title: title, body: body, description: description, tag_list: tag_list, slug: slug } }
    let(:user) { create(:user) }
    let(:user_post) { create(:integral_post) }

    describe 'GET index' do
      context 'when not logged in' do
        it 'redirects to login page' do
          get :index

          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'when logged in' do
        before do
          sign_in user
          get :index
        end

        it { expect(response.status).to eq 200 }
        it { expect(response).to render_template 'index' }
      end
    end

    describe 'POST create' do
      context 'when not logged in' do
        it 'redirects to login page' do
          post :create, post: post_params

          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'when logged in' do
        before { sign_in user }

        context 'when valid post params supplied' do
          it 'redirects to the saved post' do
            post :create, post: post_params

            expect(response).to redirect_to edit_post_path(assigns[:post])
          end

          it 'saves a new post' do
            expect {
              post :create, post: post_params
            }.to change(Post, :count).by(1)
          end
        end

        context 'when invalid post params supplied' do
          it 'does not save a new post' do
            expect {
              post :create, post: post_params.merge!(title: '')
            }.not_to change(Post, :count)
          end

          it 'renders new template' do
            post :create, post: post_params.merge!(title: '')

            expect(response).to render_template("new")
          end
        end
      end
    end

    describe 'GET new' do
      context 'when not logged in' do
        before { get :new }

        it { expect(response).to redirect_to new_user_session_path }
      end

      context 'when logged in' do
        before do
          sign_in user
          allow(Post).to receive(:new).and_return :foo
          get :new
        end

        it { expect(response.status).to eq 200 }
        it { expect(assigns(:post)).to eq :foo }
        it { expect(response).to render_template 'new' }
      end
    end

    describe 'GET edit' do
      context 'when not logged in' do
        before { get :edit, id: user_post.id }

        it { expect(response).to redirect_to new_user_session_path }
      end

      context 'when logged in' do
        before do
          sign_in user
          get :edit, id: user_post.id
        end

        it { expect(assigns[:post]).to eq user_post }
        it { expect(response).to render_template 'edit' }
      end
    end

    describe 'PUT update' do
      context 'when not logged in' do
        before { put :update, id: user_post.id, post: post_params }

        it { expect(response).to redirect_to new_user_session_path }
      end

      context 'when logged in' do
        before do
          sign_in user
          put :update, id: user_post.id, post: post_params
          user_post.reload
        end

        context 'when valid parameters supplied' do
          it { expect(response).to redirect_to(edit_post_path(user_post)) }
          it { expect(user_post.title).to eql title }
          it { expect(user_post.body).to eql body }
        end

        context 'when invalid parameters supplied' do
          let(:body) { '' }

          it { expect(user_post.title).not_to eql title }
          it { expect(user_post.body).not_to eql body }
          it { expect(response).to render_template 'edit' }
        end
      end
    end

    describe 'DELETE destroy' do
      context 'when not logged in' do
        before { delete :destroy, id: user_post.id }

        it { expect(response).to redirect_to new_user_session_path }
      end

      context 'when logged in' do
        before do
          sign_in user
          delete :destroy, id: user_post.id
        end

        it { expect { user_post.reload }.to raise_error(ActiveRecord::RecordNotFound) }
        it { expect(response).to redirect_to posts_path }
      end
    end
  end
end
