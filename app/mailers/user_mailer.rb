class UserMailer < ApplicationMailer
  default from: 'nick@samepageco.app'

 def welcome_email
   @user = params[:user]
   @url  = 'https://samepageco.app/login'
   mail(to: @user.email, bcc: "nick@samepageco.app", subject: 'Welcome to SamePage!')
 end

 def maintenance_notification
   @user = User.find_by_id(params[:maintenance_request][:user_id])
   contractors = ["nick@samepageco.app"]
   @contractors = Contractor.all
   @contractors.each do |contractor|
     contractors << contractor.email
   end
   binding.pry
   @maintenance_request = params[:maintenance_request]
   @url  = 'https://samepageco.app/maintenance_requests'
   mail(to: @user.email,
     # bcc: contractors,
     subject: 'New Maintenance Request Created')
 end
end
