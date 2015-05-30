class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @user = current_user
    @search_terms = @user.search_terms
  end
end