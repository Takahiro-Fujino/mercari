class ProductsController < ApplicationController
  before_action :move_to_signup, except: %i[index show search]
  before_action :set_product, only: %i[show edit update destroy]
  protect_from_forgery except: :create

  def index; end

  def new
    @product = Product.new
    @product.product_images.build
  end

  def show
    @product_images = @product.product_images
    @comment = Comment.new
    @comments = @product.comments.includes(:user)
    @like = Like.new
  end

  def create
    @product = Product.new(product_sale_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.user_id == current_user.id
      @product.update(product_sale_params)
      redirect_to product_path
    end
  end

  def destroy
    @product.destroy if @product.user_id == current_user.id
    flash[:notice] = "商品を削除しました"
    redirect_to root_path
  end

  def search
    @product = Product.new
    @product.product_images.build
  end

  private

  def product_sale_params
    params.require(:product).permit(:name, :product_description, :category1_id, :category2_id, :category3_id, :brand, :postage, :price, :condition, :shipping_method, :ship_from, :shipping_date, :image, product_images_attributes: [:product_image]).merge(sales_condition: 0, user_id: current_user.id)
  end

  def move_to_signup
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
