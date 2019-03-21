require 'rails_helper'
require 'payjp'

describe BuysController do
  let(:product) { create(:product) }
  let(:user) { create(:user) }
  let(:address) { create(:address) }
  let(:credit) { create(:credit) }

  describe 'GET #new' do
    context 'log in' do
      before do
        login user
        get :new, params: { product_id: product.id }
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    context 'log in' do
      before do
        login user
      end

      it 'redirects the root_path' do
        get :create, params: { product_id: product.id }
        expect(response).to redirect_to root_path
      end
    end
  end
end
