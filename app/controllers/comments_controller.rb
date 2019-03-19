class CommentsController < ApplicationController
  def create
    @comment = Comment.create(text: comment_params[:text], product_id: comment_params[:product_id], user_id: current_user.id)
      respond_to do |format|
      format.html { redirect_to "/products/#{@comment.product.id}" }
      format.json
    end
  end

  def destroy
    # @product = product.find(params[:product_id])
    @comment = Comment.find(params[:id])
    @product = @comment.product
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to product_path(@product)
    end
  end

  private
  def comment_params
    params.permit(:text, :product_id)
  end
end
