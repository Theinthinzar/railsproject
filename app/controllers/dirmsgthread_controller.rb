class DirmsgthreadController < ApplicationController

  #To insert thread message into t_dirmessage_replies table
  def dirthreadinsert
    @dirthread = HDirmessageReply.new
    @dirthread.reply_user_id = session[:user_id]
    @dirthread.dirmsg_id = session[:dirthread_id]
    @dirthread.dirthread_msg = params[:dirmsgthread][:dirmessage]
    @dirthread.is_read = 0
    @dirthread.save
    redirect_back(fallback_location: dirthreadinsert_path)
  end

  #To show thread messages and origin message
  def new
    dirthread = TDirmessage.find_by(dirmsg_id: params[:dirthread_id])
    directthread dirthread
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
    #TChunreadMessage.joins("join t_channel_messages on t_channel_messages.chmsg_id=t_chunread_messages.chmsg_id")
                    #.where("chuser_id=?  and t_channel_messages.channel_id =? ", session[:user_id], session[:clickchannel_id]).update_all(is_read: 0)
    main
    #@pubarray = Array.new
    #@m_channel.each { |r|
      #@pubarray.push(r.user_id)
    #}
    #@public_channel_list = MChannel.select("distinct m_channels.channel_name,m_channels.channel_id")
                                   #.joins("join m_workspaces on m_workspaces.workspace_id = m_channels.workspace_id  ")
                                   #.where(" m_channels.status=1 and m_workspaces.workspace_id=? ", session[:workspace_id])
  end

  #To review the reply messages
  def replymsg
    @dirreply_msg = HDirmessageReply.select("m_users.user_name,h_dirmessage_replies.dirmsg_id,h_dirmessage_replies.dirthread_msg,h_dirmessage_replies.created_at")
                                    .joins("join m_users on m_users.user_id=h_dirmessage_replies.reply_user_id")
                                    .where("h_dirmessage_replies.dirmsg_id=?", params[:clickid]).order("h_dirmessage_replies.created_at ASC")
    #TChunreadMessage.joins("join t_channel_messages on t_channel_messages.chmsg_id=t_chunread_messages.chmsg_id")
                    #.where("chuser_id=?  and t_channel_messages.channel_id =? ", session[:user_id], session[:clickchannel_id]).update_all(is_read: 0)
    main
  end
end
