class UsersController < ApplicationController


  def new
    # TODO: uncomment once sessions and current_user has been set up
    # if current_user
    #   redirect_to user_path(current_user)
    # end
    @user = User.new
  end

end
