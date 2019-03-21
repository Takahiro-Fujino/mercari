class BuysController < ApplicationController
  require 'payjp'

  def new
    @product = Product.find(params[:product_id])
    @address = current_user.address
  end

  def create
    @product = Product.find(params[:product_id])
    @order = Order.new(product_sale_params)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    charge = Payjp::Charge.create(amount: @product.price, card: params['payjp-token'], currency: 'jpy')
    @product.update_column(:sales_condition, '1')
    @order.save
    flash[:notice] = "支払いが完了しました"
    redirect_to root_path
  end

  private

  def product_sale_params
    params.permit(:product_id).merge(user_id: current_user.id)
  end
end
