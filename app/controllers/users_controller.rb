class UsersController < ApplicationController

  def show
    @email = current_user.email
  end

end
