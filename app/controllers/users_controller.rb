class UsersController < ApplicationController

  def show
    @email = current_user.email
    @tweets = Tweet.where(user_id: current_user.id)
  end

end
