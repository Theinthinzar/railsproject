class WorkspaceController < ApplicationController

  #To show workspace page
  def new
    @m_workspace = MWorkspace.new
  end

  #for creating new workspace,when click create button
  def create
     @m_workspace = MWorkspace.new(workspace_params)
     if @m_workspace.workspace_name.blank?
      flash[:danger] = "Write your workspace name!"
      redirect_to wscreate_path
    else
      @m_workspace.admin = 1
      @m_workspace.user_id = session[:user_id]
      @w = MWorkspace.select("*").where("workspace_name=?", @m_workspace.workspace_name)
      @ary = Array.new
      @w.each { |w|
        @ary.push(w.user_id)
      }
      if !@ary.include?(session[:user_id])
        @m_workspace.save
        @currwork = MWorkspace.find_by("user_id=? and workspace_name=?", session[:user_id], @m_workspace.workspace_name)
        current @currwork
        redirect_to home_path
      else
        flash[:danger] = "Workspace Name is already taken!"
        redirect_to wscreate_path
      end
    end
  end

  private

  def workspace_params
    params.require(:m_workspace).permit(:workspace_name)
  end

  def cleanup(integer)
    integer.titleize
  end
end
