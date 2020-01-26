class UserMailer < ApplicationMailer
  default from: 'nick.lisauskas@gmail.com'

 def welcome_email
   @user = params[:user]
   @url  = 'http://samepage.com/login'
   mail(to: @user.email, subject: 'Welcome to SamePage!')
 end

 def maintenance_notification
   @user = User.find_by_id(params[:maintenance_request][:user_id])
   @maintenance_request = params[:maintenance_request]
   @url  = 'http://samepage.com/maintenance_requests'
   mail(to: @user.email, subject: 'New Maintenance Request Created')
 end
end
