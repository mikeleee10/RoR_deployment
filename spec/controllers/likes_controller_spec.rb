require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    @secret = @user.secrets.create(content: "secret")
    @like = @user.likes.create(secret:@secret)
  end
  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access create" do
      get :create, id: @user
      expect(response).to redirect_to ('/sessions/new')
    end
    it "cannot access destroy" do
      get :destroy, id: @user
      expect(response).to redirect_to ('/sessions/new')
    end
  end
  describe "when signed in as the wrong user" do
    before do
      @wrong_user = create_user 'julius', 'julius@lakers.com'
      session[:user_id] = @wrong_user.id
      @secret = @user.secrets.create(content: 'Ooops')
    end
    it "cannot access destroy" do
      delete :destroy, id: @like, user_id: @user
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
  end
end
