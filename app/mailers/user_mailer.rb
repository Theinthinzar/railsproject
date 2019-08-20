class UserMailer < ApplicationMailer
    default from: "shinehtetucsm@gmail.com"
  

  def signup_confirmation(user,workspace,workspacename)
   
    @user = user
    @workspace = workspace
    @workspace_name = workspacename
    mail to: user.user_email, subject: "Sign Up Confirmation"
  end
end
