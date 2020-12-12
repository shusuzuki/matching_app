class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    unless user_signed_in?
      render template: "static_pages/home"
    end
  end

  def show
    @company = Company.find(params[:id])
    @qualification = @company.qualification.join("/")
    unless company_signed_in? || user_signed_in?
      render template: "static_pages/home"
    end
  end

  private

  def company_params
    params.require(:user).permit(:company_name, :email, :qualification)
  end
end
