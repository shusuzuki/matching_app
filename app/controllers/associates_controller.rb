class AssociatesController < ApplicationController
  before_action :authenticate_company!
  def follow
    current_company.follow(params[:id])
    redirect_to user_path
  end

  def unfollow
    current_company.unfollow(params[:id])
    redirect_to user_path
  end
end
