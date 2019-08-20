class SessionsController < ApplicationController
  #new button for showing login page
  def new
  end

  #search button for showing search page
  def search
  end

  #when click search button,workspace_name will show if the data exist in m_workspaces table
  def wsearch
    @curwork = MWorkspace.find_by("user_id=? and workspace_name=?", session[:user_id], params[:session][:name])
    if @curwork
      current @curwork
      redirect_to home_path
    else
      flash[:danger] = "The workspace does not exist" 
      redirect_to search_path
    end
  end

  #To check email and password
  def create
    m_user = MUser.find_by(user_email: params[:session][:user_email].downcase)
    if m_user && m_user.authenticate(params[:session][:user_password])
      log_in m_user
      redirect_to workspacehome_path
    else
      flash[:danger] = "Invalid email/password combination" 
      render "new"
    end
  end

  #To destroy session workspace and user
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
