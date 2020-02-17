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
   contractors = ["nick@samepageco.app"]
   @contractors = Contractor.all

   def active_category
     if @maintenance_request.category = 'Plumbing'
       'plumber'
     elsif @maintenance_request.category = 'Landscaping'
       'landscaper'
     elsif @maintenance_request.category = 'Painting'
       'painter'
     elsif @maintenance_request.category = 'HVAC'
       'HVAC'
     elsif @maintenance_request.category = 'Electricity'
       'electrician'
     elsif @maintenance_request.category = 'Locks / Security'
       'locksmith'
     elsif @maintenance_request.category = 'Floors'
       'flooring specialist'
     elsif @maintenance_request.category = 'Windows'
       'window expert'
     elsif @maintenance_request.category = 'Pests'
       'pest control'
     elsif @maintenance_request.category = 'Miscellaneous'
       'handyman'
     end
   end

   @contractors.each do |contractor, occupation|
     if contractor.occupation.to_s.downcase == active_category
     contractors << contractor.email
    end
   end
   @url  = 'https://samepageco.app/maintenance_requests'
   mail(to: @user.email,
     bcc: contractors,
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
end
