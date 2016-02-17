class StaticPagesController < ApplicationController
  before_action :require_logged_in

  def root
    redirect_to user_path(current_user)
  end
end
