class UsersController < ApplicationController
  def index
    # @users = User.by_karma.limit(50)
    # User.karma_method
    # @users = User.find(:all, limit: 50)

     @users = User.paginate(page: params[:page])
  end
end


 # @microposts = @user.microposts.paginate(page: params[:page])