class UserMailer < ApplicationMailer
  default from: 'nick@samepageco.app'

 def welcome_email
   @user = params[:user]
   @url  = 'https://samepageco.app/login'
   mail(to: @user.email, bcc: "nick@samepageco.app", subject: 'Welcome to SamePage!')
 end

 def maintenance_notification
   @user = User.find_by_id(params[:maintenance_request][:user_id])
   @maintenance_request = params[:maintenance_request]
   @url  = 'https://samepageco.app/maintenance_requests'
   mail(to: @user.email,
     bcc: 'nick@samepageco.app',
     subject: 'New Maintenance Request Created')
 end

 def contractor_maintenance_notification
   @maintenance_request = params[:maintenance_request]
   contractors = ["nick@samepageco.app"]

   def active_category
     if @maintenance_request.category == 'Plumbing'
       'plumber'
     elsif @maintenance_request.category == 'Landscaping'
       'landscaper'
     elsif @maintenance_request.category == 'Painting'
       'painter'
     elsif @maintenance_request.category == 'HVAC'
       'HVAC'
     elsif @maintenance_request.category == 'Electricity'
       'electrician'
     elsif @maintenance_request.category == 'Locks / Security'
       'locksmith'
     elsif @maintenance_request.category == 'Floors'
       'flooring specialist'
     elsif @maintenance_request.category == 'Windows'
       'window expert'
     elsif @maintenance_request.category == 'Pests'
       'pest control'
     elsif @maintenance_request.category == 'Miscellaneous'
       'handyman'
     end
   end

   Contractor.all.each do |contractor, occupation|
     if contractor.occupation.to_s.downcase == active_category
     contractors << contractor.email
    end
   end
   @url  = 'https://samepageco.app/maintenance_requests'
   mail(bcc: contractors,
     subject: 'New Maintenance Request Created')
 end

 def bid_notification
   @user = params[:user]
   @bid = params[:bid]
   @contractor = params[:contractor]

   @url  = "https://samepageco.app/maintenance_requests/#{@bid.maintenance_request.id}"
   mail(to: @user.email,
     bcc: 'nick@samepageco.app',
     subject: 'You Received A New Bid')
 end

 def contractor_award_notification
   @bid = params[:bid]
   @contractor = params[:contractor]

   @url  = "https://samepageco.app/maintenance_requests/#{@bid.maintenance_request.id}"
   mail(to: @contractor.email,
     bcc: 'nick@samepageco.app',
     subject: 'Your Bid Was Approved!')
 end

 def comment_notification
   @comment = params[:comment]
   @bid = params[:bid]

   @url  = "https://samepageco.app/maintenance_requests"
   mail(
     bcc: [@bid.contractor.email, @bid.maintenance_request.user.email, 'nick@samepageco.app'],
     subject: "A new comment was added to a bid for #{@bid.maintenance_request.title}")
 end

 def contractor_resolved_notification
   @user = User.find_by_id(params[:user])
   @maintenance_request = params[:maintenance_request]
   @url  = 'https://samepageco.app/maintenance_requests'
   mail(to: @user.email,
     bcc: 'nick@samepageco.app',
     subject: 'Maintenance Request Completed')
 end

 def forgot_password(user)
  @user = user
  @greeting = "Hi"

  mail to: user.email, :subject => 'Reset password instructions'
end

end
