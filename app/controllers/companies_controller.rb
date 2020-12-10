class CompaniesController < ApplicationController
  before_action :authenticate_company!, only: [:show]
  def show
    @company = Company.find(params[:id])
    @qualification = @company.qualification.join("/")
  end

  private

  def company_params
    params.require(:user).permit(:company_name, :email, :qualification)
  end
end
