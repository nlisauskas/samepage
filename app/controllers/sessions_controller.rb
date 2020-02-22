class SessionsController < ApplicationController
  def create
    if params[:category] == "Landlord"
     user = User.find_by_email(params[:email])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect_to maintenance_requests_url, notice: "Logged in!"
     else
       flash.now[:alert] = "Email or password is invalid"
       render "new"
     end
   elsif params[:category] == "Contractor"
     contractor = Contractor.find_by_email(params[:email])
     if contractor && contractor.authenticate(params[:password])
       session[:contractor_id] = contractor.id
       redirect_to maintenance_requests_url, notice: "Logged in!"
     else
       flash.now[:alert] = "Email or password is invalid"
       render "new"
     end
   end
  end

   def destroy
     if session[:user_id]
       session[:user_id] = nil
      else
       session[:contractor_id] = nil
      end
     redirect_to root_url, notice: "Logged out!"
   end
 end
