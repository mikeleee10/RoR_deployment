class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def show
    @user = User.find(params[:id])
  end
  def new
  end
  def create
    user = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/users/new'
    end
  end
  def edit
    @user = User.find(session[:user_id])
  end
  def update
    user = User.find(session[:user_id]).update(name: params[:name], email: params[:email])
    if user
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to "/users/#{session[:user_id]}/edit"
    end
  end
  def destroy
    User.find(session[:user_id]).destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end
end
