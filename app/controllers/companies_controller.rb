class CompaniesController < ApplicationController
  def index
    @q = Company.ransack(params[:q])
    @companies = @q.result(distinct: true).page(params[:page]).per(10)
    unless user_signed_in?
      render template: "static_pages/home"
    end
  end

  def show
    @company = Company.find(params[:id])
    @qualification = @company.qualification.gsub(/"/) { '' }.delete("[]")
    @matchers = @company.matchers
    if company_signed_in?
      rooms = current_company.rooms
      @user_ids = []
      rooms.each do |r|
        @user_ids << r.user_id
      end
    end
    unless company_signed_in? || user_signed_in?
      render template: "static_pages/home"
    end
  end

  def following
    @title = "フォロー中"
    @company = Company.find(params[:id])
    @companies = @company.following.page(params[:page]).per(10)
    render 'company_follow'
  end

  def followers
    @title = "フォロワー"
    @company = Company.find(params[:id])
    @companies = @company.followers.page(params[:page]).per(10)
    render 'company_follow'
  end

  private

  def company_params
    params.require(:user).permit(:company_name, :email, :qualification)
  end
end
