class JoinmembersController < ApplicationController
  def new
  @member = MUser.new
  end
  def create
  @m_user = MUser.new(user_params)  
  @m_user.user_email = params[:user_email]
  @m_user.save
  @curuser=MUser.find_by("user_name=? and user_email=?",@m_user.user_name,@m_user.user_email)
  log_in @m_user
  user_current @curuser  
  @workspace = MWorkspace.new
  @workspace.workspace_id = params[:workspaceid]
  @workspace.workspace_name = params[:workspacename]
  @workspace.user_id =  session[:current_id] 
  @workspace.admin = 0
  @workspace.save
  current @workspace 
  redirect_to home_path
  end
def user_params
  params.require(:joinmembers).permit(:user_name,:password,
                               :password_confirmation)
end
end
