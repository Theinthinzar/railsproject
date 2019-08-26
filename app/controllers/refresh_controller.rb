class RefreshController < ApplicationController
  def new
    #for navigation
    @chcount = 0
    @totalcount = 0
    @dircount = 0
    #@workspace1 = MWorkspace.select("*")
    #.where("workspace_id=? and user_id=?", session[:workspace_id], session[:user_id])
    @curworkuser = MUser.select("*")
      .joins("join m_workspaces on m_workspaces.user_id = m_users.user_id")
      .where("m_workspaces.workspace_id=?", session[:workspace_id])
    @curworkuser.each { |userid|
      @dirunread = TDirmessage.select("*")
                              .where("receiver_user_id=? and sender_user_id=? and dirworkspace_id=? and is_read=true", session[:user_id], userid.user_id, session[:workspace_id])
      userid.user_email = (@dirunread.size).to_s
      @dircount += @dirunread.size
    }
    @m_channel = MChannel.joins("join m_workspaces on m_workspaces.workspace_id = m_channels.workspace_id and m_channels.user_id = m_workspaces.user_id ")
                         .where("m_workspaces.workspace_id=? and m_channels.user_id=?", session[:workspace_id], session[:user_id])
    @m_channel.each { |channelid|
      @chunread = TChunreadMessage.select("*")
                                  .joins("join t_channel_messages on t_channel_messages.chmsg_id=t_chunread_messages.chmsg_id")
                                  .where("chuser_id=?  and t_channel_messages.channel_id =? and is_read=true", session[:user_id], channelid.channel_id)
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
                                   .where(" m_channels.status=true and m_workspaces.workspace_id=? and m_channels.user_id!=?", session[:workspace_id], session[:user_id])
    #for dierect message

    @message = TDirmessage.select("m_users.user_id,m_users.user_name,t_dirmessages.dir_message,t_dirmessages.dirmsg_id,t_dirmessages.created_at,t_dirmessages.dirmsg_id,t_dirmessages.count")
                          .joins("join m_users on t_dirmessages.sender_user_id = m_users.user_id")
                          .where("((receiver_user_id=? and sender_user_id=?) or (receiver_user_id=? and sender_user_id=?))", session[:user_id], session[:clickuser_id], session[:clickuser_id], session[:user_id]).order("created_at ASC")
    @dstar = TDirmessage.select("t_directstars.stardimsg_id")
      .joins("join t_directstars on t_directstars.stardimsg_id=t_dirmessages.dirmsg_id")
      .where("dirworkspace_id=? and t_directstars.star_userid=?", session[:workspace_id], session[:user_id])
    @array = Array.new
    @dstar.each { |r|
      @array.push(r.stardimsg_id)
    }
    @message.each { |thread|
      @thredcount = HDirmessageReply.select("*")
                                    .joins("join t_dirmessages on t_dirmessages.dirmsg_id=h_dirmessage_replies.dirmsg_id")
                                    .where("h_dirmessage_replies.dirmsg_id=?", thread.dirmsg_id)
      thread.count = @thredcount.size
    }
    #channel message
    @chmesg = TChannelMessage.select("m_users.user_name,t_channel_messages.chmsg_id,t_channel_messages.count,t_channel_messages.chmessage,t_channel_messages.created_at,t_channel_messages.updated_at")
                             .joins("join m_users on m_users.user_id=t_channel_messages.chsender_id")
                             .where("channel_id=?", session[:clickchannel_id]).order("t_channel_messages.created_at ASC")
    @chmesg.each { |thread|
      @thredcount = HChmessageReply.select("*")
        .joins("join t_channel_messages on t_channel_messages.chmsg_id=h_chmessage_replies.chmsg_id")
        .where("h_chmessage_replies.chmsg_id=?", thread.chmsg_id)
      thread.count = (@thredcount.size).to_s
    }
    @chstar = TChmsgstar.select("t_chmsgstars.chmsgstarid")
                        .joins("join t_channel_messages on t_chmsgstars.chmsgstarid=t_channel_messages.chmsg_id")
                        .where("channel_id=? and t_chmsgstars.chstar_userid=?", session[:clickchannel_id], session[:user_id])
    @charray = Array.new
    @chstar.each { |r|
      @charray.push(r.chmsgstarid)
    }
    @muser = MUser.select("m_users.user_id, m_users.user_name")
                  .joins("join m_channels on m_users.user_id=m_channels.user_id ")
                  .where("m_channels.channel_id=? and m_users.user_id !=?", session[:clickchannel_id], session[:user_id])

    #dirthread message
    @dirmsg_original = TDirmessage.select("m_users.user_name,t_dirmessages.count,t_dirmessages.dirmsg_id,t_dirmessages.dir_message,t_dirmessages.created_at")
                                  .joins("join m_users on m_users.user_id=t_dirmessages.sender_user_id")
                                  .where("t_dirmessages.dirmsg_id=?", session[:dirthread_id]).order("t_dirmessages.created_at ASC")
    @dirthread_msg = HDirmessageReply.select("m_users.user_name,h_dirmessage_replies.dirmsg_id,h_dirmessage_replies.dirthread_msg,h_dirmessage_replies.created_at")
                                     .joins("join m_users on m_users.user_id=h_dirmessage_replies.reply_user_id")
                                     .where("h_dirmessage_replies.dirmsg_id=? and h_dirmessage_replies.reply_user_id=?", session[:dirthread_id], session[:user_id]).order("h_dirmessage_replies.created_at ASC")
    @dirmsg_original.each { |thread|
      @thredcount = HDirmessageReply.select("*")
                                    .joins("join t_dirmessages on t_dirmessages.dirmsg_id=h_dirmessage_replies.dirmsg_id")
                                    .where("h_dirmessage_replies.dirmsg_id=?", thread.dirmsg_id)
      thread.count = (@thredcount.size).to_s
    }
    @chmsg_original = TChannelMessage.select("m_users.user_name,t_channel_messages.chmsg_id,t_channel_messages.count,t_channel_messages.chmessage,t_channel_messages.created_at,t_channel_messages.updated_at")
                                     .joins("join m_users on m_users.user_id=t_channel_messages.chsender_id")
                                     .where("t_channel_messages.chmsg_id=?", session[:chthread_id]).order("t_channel_messages.created_at ASC")
    @chthread_msg = HChmessageReply.select("m_users.user_name,h_chmessage_replies.chmsg_id,h_chmessage_replies.chthreadmsg,h_chmessage_replies.created_at")
                                   .joins("join m_users on m_users.user_id=h_chmessage_replies.chreplyer_id")
                                   .where("h_chmessage_replies.chmsg_id=? and h_chmessage_replies.chreplyer_id=?", session[:chthread_id], session[:user_id]).order("h_chmessage_replies.created_at ASC")
    @chmsg_original.each { |thread|
      @thredcount = HChmessageReply.select("*")
                                   .joins("join t_channel_messages on t_channel_messages.chmsg_id=h_chmessage_replies.chmsg_id")
                                   .where("h_chmessage_replies.chmsg_id=?", thread.chmsg_id)
      thread.count = (@thredcount.size).to_s
    }
    #chreply message

    respond_to do |format|
      format.js
    end
  end
end
