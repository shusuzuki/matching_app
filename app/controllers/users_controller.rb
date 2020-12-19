class UsersController < ApplicationController
  require 'happybirthday'
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
    unless company_signed_in?
      render template: "static_pages/home"
    end
  end

  def show
    @user = User.find(params[:id])
    @qualification = @user.qualification.gsub(/"/) { '' }.delete("[]")
    @matchers = @user.matchers
    birthday = Happybirthday.born_on(@user.birth_date)
    @birthday = birthday.age.years_old
    if user_signed_in?
      rooms = current_user.rooms
      @company_ids = []
      rooms.each do |r|
        @company_ids << r.company_id
      end
    end
    unless company_signed_in? || user_signed_in?
      render template: "static_pages/home"
    end
  end

  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render 'user_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'user_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :qualification)
  end
end
