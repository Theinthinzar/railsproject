class DirectmessageController < ApplicationController

  #when click send button,the messages will insert into t_dirmessages table
  def create
    @t_dirmessages = TDirmessage.new
    @t_dirmessages.is_read = 1
    @t_dirmessages.sender_user_id = session[:user_id]
    @t_dirmessages.receiver_user_id = session[:clickuser_id]
    @t_dirmessages.dir_message = params[:dirmessages][:dir_message]
    @t_dirmessages.dirworkspace_id = session[:workspace_id]
    @t_dirmessages.save
    redirect_back(fallback_location: dirmsgcreate_path)
  end

  #To show direct messages
  def new
    @currentname = MUser.find_by("user_id=?", params[:clickuser_id])
    clickuser @currentname
    TDirmessage.where("receiver_user_id=? and sender_user_id=? and dirworkspace_id=?", session[:user_id], params[:clickuser_id], session[:workspace_id]).update_all(is_read: 0)
    main
    @message = TDirmessage.select("m_users.user_id,m_users.user_name,t_dirmessages.dir_message,t_dirmessages.dirmsg_id,t_dirmessages.created_at,t_dirmessages.dirmsg_id,t_dirmessages.count")
                          .joins("join m_users on t_dirmessages.sender_user_id = m_users.user_id")
                          .where("((receiver_user_id=? and sender_user_id=?) || (receiver_user_id=? and sender_user_id=?))", session[:user_id], params[:clickuser_id], params[:clickuser_id], session[:user_id]).order("created_at ASC")
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
    #@pubarray = Array.new
    #@m_channel.each { |r|
      #@pubarray.push(r.channel_name)
    #}
    #@public_channel_list = MChannel.select("distinct m_channels.channel_name,m_channels.channel_id")
                                   #.joins("join m_workspaces on m_workspaces.workspace_id = m_channels.workspace_id")
                                   #.where(" m_channels.status=1 and m_workspaces.workspace_id=? and m_channels.user_id!=?", session[:workspace_id], session[:user_id])
    #@dirmsg_original = TDirmessage.select("m_users.user_name,t_dirmessages.count,t_dirmessages.dirmsg_id,t_dirmessages.dir_message,t_dirmessages.created_at")
                                  #.joins("join m_users on m_users.user_id=t_dirmessages.sender_user_id")
                                  #.where("t_dirmessages.dirmsg_id=?", session[:dirthread_id]).order("t_dirmessages.created_at ASC")
    #@dirthread_msg = HDirmessageReply.select("m_users.user_name,h_dirmessage_replies.dirmsg_id,h_dirmessage_replies.dirthread_msg,h_dirmessage_replies.created_at")
                                     #.joins("join m_users on m_users.user_id=h_dirmessage_replies.reply_user_id")
                                     #.where("h_dirmessage_replies.dirmsg_id=? and h_dirmessage_replies.reply_user_id=?", session[:dirthread_id], session[:user_id]).order("h_dirmessage_replies.created_at ASC")
    #@dirmsg_original.each { |thread|
      #@thredcount = HDirmessageReply.select("*")
                                    #.joins("join t_dirmessages on t_dirmessages.dirmsg_id=h_dirmessage_replies.dirmsg_id")
                                    #.where("h_dirmessage_replies.dirmsg_id=?", thread.dirmsg_id)
      #thread.count = @thredcount.size
    #}
  
  end

  #To delete direct messages
  def messagedelete
    TDirmessage.find_by("dirmsg_id=?", params[:messagedelete]).delete
    redirect_back(fallback_location: dirmsgcreate_path)
  end
end
