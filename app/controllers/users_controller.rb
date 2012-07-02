class UsersController < ApplicationController

  def show
  	@title = "Edit Your Markets"
    @user = User.find(params[:id])
    render :layout => "markets"
  end
end
