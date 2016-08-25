class LikesController < ApplicationController
  before_action :require_login
  def create
    current_user.likes.create(secret:Secret.find(params[:secret_id]))
    redirect_to :back
  end
  def destroy
    Like.where(user: current_user, secret: params[:secret_id]).destroy_all
    redirect_to '/secrets'
  end
end
