class UsersController < ApplicationController
  before_action :move_to_index, except: [:new]

  def new; end

  def show
    @user = User.find(params[:id])
  end

  def logout; end

  def confirmation; end

  def profile; end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

  def move_to_index
    redirect_to '/' unless user_signed_in?
  end
end
