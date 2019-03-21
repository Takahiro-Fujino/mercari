class Category2sController < ApplicationController
  def index
    category1 = Category1.find(params[:category1_id])
    category2s = category1.category2s.map do |category2|
      {
        id: category2.id,
        name: category2.name,
        path: "/category1s/#{params[:category1_id]}/category2s/#{category2.id}/category3s"
      }
    end
    render json: category2s
  end
end
