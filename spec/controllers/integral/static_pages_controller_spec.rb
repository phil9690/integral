require 'rails_helper'

module Integral
  describe StaticPagesController, type: :controller do
    routes { Integral::Engine.routes }

    describe 'GET home' do
      before do
        get :home
      end

      it { expect(response.status).to eq 200 }
    end
  end
end
