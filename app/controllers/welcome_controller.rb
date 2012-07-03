class WelcomeController < ApplicationController
  def show
    redirect_to markets_path if current_user
  end
end
