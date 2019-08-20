class ThreadsController < ApplicationController

  #To display origin messages and thread messages
  def new
    @chmsg = TChannelMessage.select("distinct t_channel_messages.chmsg_id,m_channels.channel_name ,m_users.user_name ,t_channel_messages.chmessage,t_channel_messages.created_at")
                            .joins("join m_users on t_channel_messages.chsender_id=m_users.user_id 
                                    join h_chmessage_replies on h_chmessage_replies.chmsgid=t_channel_messages.chmsg_id
                                    join m_channels on m_channels.channel_id=t_channel_messages.channel_id")
                            .where("(t_channel_messages.chsender_id=? or h_chmessage_replies.chreplyer_id=?) and m_channels.user_id = ? and m_channels.workspace_id=? ", session[:user_id], session[:user_id], session[:user_id], session[:workspace_id])

    @chmsgthrd = HChmessageReply.select("h_chmessage_replies.chmsgid,m_users.user_name,h_chmessage_replies.chthreadmsg,h_chmessage_replies.created_at")
                                .joins("join m_users on h_chmessage_replies.chreplyer_id=m_users.user_id 
                                        join t_channel_messages on h_chmessage_replies.chmsgid=t_channel_messages.chmsg_id")
                                .where("t_channel_messages.chsender_id=? or h_chmessage_replies.chreplyer_id=? ", session[:user_id], session[:user_id])

    @dirmsg = TDirmessage.select("distinct t_dirmessages.dirmsg_id,m_users.user_name ,t_dirmessages.dir_message,t_dirmessages.created_at")
                         .joins("join m_users on t_dirmessages.sender_user_id=m_users.user_id 
                                 join h_dirmessage_replies on h_dirmessage_replies.dirmsg_id=t_dirmessages.dirmsg_id")
                         .where("(((receiver_user_id=? and sender_user_id=?) or (receiver_user_id=? and sender_user_id=?)) or h_dirmessage_replies.reply_user_id=?) and t_dirmessages.dirworkspace_id=?", session[:user_id], session[:user_id], session[:user_id], session[:user_id], session[:user_id], session[:workspace_id])

    @dirmsgthrd = HDirmessageReply.select("h_dirmessage_replies.dirmsg_id,m_users.user_name,h_dirmessage_replies.dirthread_msg,h_dirmessage_replies.created_at")
                                  .joins("join m_users on h_dirmessage_replies.reply_user_id=m_users.user_id 
                                          join t_dirmessages on h_dirmessage_replies.dirmsg_id=t_dirmessages.dirmsg_id")
                                  .where("((receiver_user_id=? and sender_user_id=?) or (receiver_user_id=? and sender_user_id=?)) or h_dirmessage_replies.reply_user_id=?", session[:user_id], session[:user_id], session[:user_id], session[:user_id], session[:user_id])

    main
    #@pubarray = Array.new
    #@m_channel.each { |r|
      #@pubarray.push(r.channel_name)
    #}
    #@public_channel_list = MChannel.select("distinct m_channels.channel_name,m_channels.channel_id")
                                   #.joins("join m_workspaces on m_workspaces.workspace_id = m_channels.workspace_id ")
                                   #.where(" m_channels.status=1 and m_workspaces.workspace_id=? and m_channels.user_id!=?", session[:workspace_id], session[:user_id])
  end
end
