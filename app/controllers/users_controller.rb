class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  require 'happybirthday'
  def show
    @user = User.find(params[:id])
    @qualification = @user.qualification.join("/")
    birthday = Happybirthday.born_on(@user.birth_date)
    @birthday = birthday.age.years_old
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :qualification)
  end
end
