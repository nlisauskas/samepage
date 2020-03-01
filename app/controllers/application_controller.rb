class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_user
  helper_method :current_contractor

def current_user
  if session[:user_id]
    @current_user ||= User.find(session[:user_id])
  else
    @current_user = nil
  end
end

def current_contractor
  if session[:contractor_id]
    @current_contractor ||= Contractor.find(session[:contractor_id])
  else
    @current_contractor = nil
  end
end
end
