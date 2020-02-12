class UserMailer < ApplicationMailer
  default from: 'nick.lisauskas@gmail.com'

 def welcome_email
   @user = params[:user]
   @url  = 'https://samepagerealestate.herokuapp.com/login'
   mail(to: @user.email, bcc: "nick.lisauskas@gmail.com", subject: 'Welcome to SamePage!')
 end

 def maintenance_notification
   @user = User.find_by_id(params[:maintenance_request][:user_id])
   contractors = ["nick.lisauskas@gmail.com"]
   @contractors = Contractor.all
   @contractors.each do |contractor|
     contractors << contractor.email
   end
   binding.pry
   @maintenance_request = params[:maintenance_request]
   @url  = 'https://samepagerealestate.herokuapp.com/maintenance_requests'
   mail(to: @user.email,
     # bcc: contractors, 
     subject: 'New Maintenance Request Created')
 end
end
