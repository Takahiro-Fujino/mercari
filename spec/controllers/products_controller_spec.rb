require 'rails_helper'

describe ProductsController do
  let(:product) { create(:product) }
  let(:user) { create(:user) }

  describe '#new' do
    context 'log in' do
      before do
        login user
        get :new
      end
      it 'assigns @product' do
        expect(assigns(:product)).to be_a_new(Product)
      end
      it 'redners new' do
        expect(response).to render_template :new
      end
    end
    context 'not log in' do
      before do
        get :new
      end
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#show' do
    it "assigns @product" do
      expect(assigns(:product)).to eq @product
    end
    it "renders show" do
      render_template :show
    end
  end

  describe 'DELETE #destroy' do
    context 'log in' do
      before do
        login user
      end
      it 'delete the product' do
        expect do
          delete :destroy, params: { id: product.id }
        end.to change(Product, :count).by(1)
      end
      it 'redirects the :create template' do
        delete :destroy, params: { id: product.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#create' do
    let(:params) { { user_id: user.id, product: attributes_for(:product) } }
    context 'log in' do
      before do
        login user
      end
      context 'can save' do
        subject do
          post :create,
               params: params
        end
        it 'count up message' do
          expect { subject }.to change(Product, :count).by(1)
        end
        it 'redirects to index' do
          subject
          expect(response).to redirect_to("/")
        end
      end
      context 'can not save' do
        let(:invalid_params) { { user_id: user.id, product: attributes_for(:product, name: nil) } }
        subject do
          post :create,
               params: invalid_params
        end
        it 'does not count up' do
          expect { subject }.not_to change(Product, :count)
        end
        it 'renders new' do
          subject
          expect(response).to render_template :new
        end
      end
    end
    context 'not log in' do
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: product.id }, session: {} }

    it 'assigns the requested product to @product' do
      expect(assigns(:product)).to eq @product
    end
  end

  describe 'PATCH #update' do
    it "locates the requersted @product" do
      patch :update, params: { id: product.id }, product: attributes_for(:product)
      expect(assigns(:product)).to eq @product
    end
    it "changes @product's attributes" do
      patch :update, params: { id: product.id }, product: attributes_for(:product, name: 'モンベル スペリオダウンジャケット', product_description: '保温性と軽量性を高次元で両立したジャケット')
      product.reload
      expect(product.name).to eq("モンベル スペリオダウンジャケット")
      expect(product.product_description).to eq("保温性と軽量性を高次元で両立したジャケット")
    end
  end

  describe '#search' do
    it "assigns @product" do
      expect(assigns(:product)).to eq @product
    end
    it "renders search" do
      get :search
      expect(response).to render_template :search
    end
  end
end
