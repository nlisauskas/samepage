class PasswordResetsController < ApplicationController
  def new
  end

  def create
    binding.pry
    if params[:category] == 'Landlord'
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:notice] = 'E-mail sent with password reset instructions.'
    redirect_to new_session_path
  elsif params[:category] == 'Contractor'
    contractor = Contractor.find_by_email(params[:email])
    contractor.send_password_reset if contractor
    flash[:notice] = 'E-mail sent with password reset instructions.'
    redirect_to new_session_path
  end
  end

  def edit
    if User.find_by_password_reset_token(params[:id])
    @user = User.find_by_password_reset_token(params[:id])
    else
    @user = Contractor.find_by_password_reset_token(params[:id])
    end
  end

  def update
    binding.pry
    if User.find_by_password_reset_token(params[:id])
    @user = User.find_by_password_reset_token(params[:id])
    else
    @user = Contractor.find_by_password_reset_token(params[:id])
    end

  if @user.password_reset_sent_at < 2.hour.ago
    flash[:notice] = 'Password reset has expired'
    redirect_to new_password_reset_path
  elsif @user.update(user_params)
    flash[:notice] = 'Password has been reset!'
    redirect_to new_session_path
  else
    render :edit
  end
end

private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    if params[:user]
    params.require(:user).permit(:password)
    else
    params.require(:contractor).permit(:password)
    end
  end

end
