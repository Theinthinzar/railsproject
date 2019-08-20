class InvitationsController < ApplicationController
  def invitemember
  end

  def new
    @user = MUser.new
  end

  def create
    @user1 = MUser.new()
    @user1.user_email = params[:invitations][:user_email1]
    if @user1.user_email != ""
      UserMailer.signup_confirmation(@user1, session[:workspace_id], session[:workspace_name]).deliver
      redirect_to home_path
    end

    @user2 = MUser.new()
    @user2.user_email = params[:invitations][:user_email2]
    if @user2.user_email != ""
      UserMailer.signup_confirmation(@user2, session[:workspace_id], session[:workspace_name]).deliver
      redirect_to home_path
    end

    @user3 = MUser.new()
    @user3.user_email = params[:invitations][:user_email3]
    @workspace3 = MWorkspace.new()
    if @user3.user_email != ""
      UserMailer.signup_confirmation(@user3, session[:workspace_id], session[:workspace_name]).deliver
      redirect_to home_path
    end
  end

  def edit
    @user = MUser.new
  end
end
