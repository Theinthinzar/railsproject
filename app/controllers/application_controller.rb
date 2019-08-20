class ApplicationController < ActionController::Base
  include SessionsHelper
  def main
    @chcount = 0
    @totalcount = 0
    @dircount = 0
    #@workspace1 = MWorkspace.select("*")
                            #.where("workspace_id=? and user_id=?", session[:workspace_id], session[:user_id])
    @curworkuser = MUser.select("*")
                    .joins("join m_workspaces on m_workspaces.user_id = m_users.user_id")
                    .where("m_workspaces.workspace_id= ?", session[:workspace_id])
    @curworkuser.each { |userid|
      @dirunread = TDirmessage.select("*")
                              .where("receiver_user_id=? and sender_user_id=? and dirworkspace_id=? and is_read=1", session[:user_id], userid.user_id, session[:workspace_id])
      userid.user_email = (@dirunread.size).to_s
      @dircount += @dirunread.size
    }
    @m_channel = MChannel.joins("join m_workspaces on m_workspaces.workspace_id = m_channels.workspace_id and m_channels.user_id = m_workspaces.user_id ")
                         .where("m_workspaces.workspace_id=? and m_channels.user_id=?", session[:workspace_id], session[:user_id])
    @m_channel.each { |channelid|
      @chunread = TChunreadMessage.select("*")
                                  .joins("join t_channel_messages on t_channel_messages.chmsg_id=t_chunread_messages.chmsg_id")
                                  .where("chuser_id=?  and t_channel_messages.channel_id =? and is_read=1", session[:user_id], channelid.channel_id)
      channelid.workspace_id = (@chunread.size).to_s
      @chcount += @chunread.size
    }
    @totalcount = @dircount + @chcount
    @pubarray = Array.new
    @m_channel.each { |r|
      @pubarray.push(r.channel_name)
    }
    @public_channel_list = MChannel.select("distinct m_channels.channel_name,m_channels.channel_id")
                                   .joins("join m_workspaces on m_workspaces.workspace_id = m_channels.workspace_id  ")
                                   .where(" m_channels.status=1 and m_workspaces.workspace_id=? and m_channels.user_id!=?", session[:workspace_id], session[:user_id])
  end
end
