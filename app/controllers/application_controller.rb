class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    case resource
    when User
      current_user
    when Company
      current_company
    end
  end
end
