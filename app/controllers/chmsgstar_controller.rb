class ChmsgstarController < ApplicationController

  #To insert star messages into t_chmsgstars table
  def new
    @t_chstar = TChmsgstar.new
    @t_chstar.chstar_userid = session[:user_id]
    @t_chstar.chmsgstarid = params[:clickchstarid]
    @t_chstar.save
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

    #@chmesg = TChannelMessage.select("m_users.user_name,t_channel_messages.chmsg_id,t_channel_messages.count,t_channel_messages.chmessage,t_channel_messages.created_at,t_channel_messages.updated_at")
                             #.joins("join m_users on m_users.user_id=t_channel_messages.chsender_id")
                             #.where("channel_id=?", session[:clickchannel_id]).order("t_channel_messages.created_at ASC")
    #@chmesg.each { |thread|
      #@thredcount = HChmessageReply.select("*")
                                   #.joins("join t_channel_messages on t_channel_messages.chmsg_id=h_chmessage_replies.chmsgid")
                                   #.where("h_chmessage_replies.chmsgid=?", thread.chmsg_id)
      #thread.count = (@thredcount.size).to_s
    #}
   # @chstar = TChmsgstar.select("t_chmsgstars.chmsgstarid")
                        #.joins("join t_channel_messages on t_chmsgstars.chmsgstarid=t_channel_messages.chmsg_id")
                        #.where("channel_id=? and t_chmsgstars.chstar_userid=?", session[:clickchannel_id], session[:user_id])
    #@charray = Array.new
    #@chstar.each { |r|
      #@charray.push(r.chmsgstarid)
    #}
    redirect_back(fallback_location: chmsgstar_path)
  end

  #click unstar button for delete star messages
  def chunstar
    TChmsgstar.where("chmsgstarid=?", params[:unchstarid]).delete_all
    redirect_back(fallback_location: channelchat_path)
  end
end
