class ChmsgthreadController < ApplicationController

  #To insert thread message into h_chmessage_replies table
  def chthreadinsert
    @chthread = HChmessageReply.new
    @chthread.chreplyer_id = session[:user_id]
    @chthread.chmsgid = session[:chthread_id]
    @chthread.chthreadmsg = params[:chmsgthread][:chmessage]
    @chthread.save
    redirect_back(fallback_location: chthreadinsert_path)
  end

  #To show thread messages and origin message
  def new
    chthread = TChannelMessage.find_by(chmsg_id: params[:chthread_id])
    channelthread chthread
    @chmsg_original = TChannelMessage.select("m_users.user_name,t_channel_messages.chmsg_id,t_channel_messages.count,t_channel_messages.chmessage,t_channel_messages.created_at,t_channel_messages.updated_at")
                                     .joins("join m_users on m_users.user_id=t_channel_messages.chsender_id")
                                     .where("t_channel_messages.chmsg_id=?", session[:chthread_id]).order("t_channel_messages.created_at ASC")
    @chthread_msg = HChmessageReply.select("m_users.user_name,h_chmessage_replies.chmsgid,h_chmessage_replies.chthreadmsg,h_chmessage_replies.created_at")
                                   .joins("join m_users on m_users.user_id=h_chmessage_replies.chreplyer_id")
                                   .where("h_chmessage_replies.chmsgid=? and h_chmessage_replies.chreplyer_id=?", session[:chthread_id], session[:user_id]).order("h_chmessage_replies.created_at ASC")
    @chmsg_original.each { |thread|
      @thredcount = HChmessageReply.select("*")
                                   .joins("join t_channel_messages on t_channel_messages.chmsg_id=h_chmessage_replies.chmsgid")
                                   .where("h_chmessage_replies.chmsgid=?", thread.chmsg_id)
      thread.count = (@thredcount.size).to_s
    }
    #TChunreadMessage.joins("join t_channel_messages on t_channel_messages.chmsg_id=t_chunread_messages.chmsg_id")
                    #.where("chuser_id=?  and t_channel_messages.channel_id =? ", session[:user_id], session[:clickchannel_id]).update_all(is_read: 0)
    main
  end

  #To review the reply messages
  def chreplymsg
    @chreplymsg = HChmessageReply.select("m_users.user_name,h_chmessage_replies.chmsgid,h_chmessage_replies.chthreadmsg,h_chmessage_replies.created_at")
                                 .joins("join m_users on m_users.user_id=h_chmessage_replies.chreplyer_id")
                                 .where("h_chmessage_replies.chmsgid=?", params[:chclickid]).order("h_chmessage_replies.created_at ASC")
    #TChunreadMessage.joins("join t_channel_messages on t_channel_messages.chmsg_id=t_chunread_messages.chmsg_id")
                    #.where("chuser_id=?  and t_channel_messages.channel_id =? ", session[:user_id], session[:clickchannel_id]).update_all(is_read: 0)
    main
  end
end
