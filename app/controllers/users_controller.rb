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
    birthday = Happybirthday.born_on(@user.birth_date)
    @birthday = birthday.age.years_old
    unless company_signed_in? || user_signed_in?
      render template: "static_pages/home"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :qualification)
  end
end
