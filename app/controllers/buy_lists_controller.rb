class BuyListsController < ApplicationController
  def index
    @orders = Order.all
    @order = Order.where(user_id: current_user.id.to_s)
  end
end
