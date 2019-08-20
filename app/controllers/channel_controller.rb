class ChannelController < ApplicationController
  #To create new channel
  def new
    @channel = MChannel.new
  end

  #To manage users from current workspace
  def managemember
    main
    @curchuser = MUser.select("*")
      .joins("join m_workspaces on m_workspaces.user_id = m_users.user_id")
      .where("m_workspaces.workspace_id= ?", session[:workspace_id]).paginate(page: params[:page], per_page: 3)
  end

  #click add button for insert users into m_channels table
  def addchmember
    @channel = MChannel.new
    @channel.channel_id = session[:clickchannel_id]
    @channel.channel_name = session[:clickchannel_name]
    @channel.user_id = params[:linkuser]
    @channel.workspace_id = session[:workspace_id]
    @channel.status = session[:clickchannel_status]
    @channel.chadmin = 0
    @channel.save
    redirect_to memberedit_path
  end

  #To show all users that does not exist in current channel from current workspace
  def chmemberinvite
    @clickchannel = MChannel.find_by("channel_id=?", session[:clickchannel_id])
    managemember
    @temp_channel = MUser.select("m_users.user_id")
                         .joins("join m_channels on m_channels.user_id=m_users.user_id")
                         .where("m_channels.channel_name=? and m_channels.workspace_id=?", session[:clickchannel_name], session[:workspace_id])
    @arychannel = Array.new
    @temp_channel.each { |r|
      @arychannel.push(r.user_id)
    }
    @count = MChannel.select("*")
                     .where("workspace_id=? and channel_id=?", session[:workspace_id], session[:clickchannel_id])
    @currentcount = (@count.size).to_s
  end

  #To remove the users that exist in current channel
  def channelremove
    MChannel.find_by("user_id=? and channel_id=?", params[:removeuser], session[:clickchannel_id]).delete
    redirect_to memberedit_path
  end

  #To delete users that exist in current workspace
  def userremove
    MWorkspace.find_by("user_id=? and workspace_id=?", params[:userremove], session[:workspace_id]).delete
    redirect_to managemember_path
  end

  #To delete channel from m_channels table
  def channeldelete
    MChannel.find_by("channel_id=? ", params[:channelremove]).delete
    redirect_to managechannel_path
  end

  #To show current channel messages
  def channelchat
    @clickchannel = MChannel.find_by("channel_id=?", params[:clickchannelid])
    clickchannel @clickchannel
    TChunreadMessage.joins("join t_channel_messages on t_channel_messages.chmsg_id=t_chunread_messages.chmsg_id")
                    .where("chuser_id=?  and t_channel_messages.channel_id =? ", session[:user_id], @clickchannel.channel_id)
                    .update_all(is_read: 0)
    main
    @chmesg = TChannelMessage.select("m_users.user_name,t_channel_messages.chmsg_id,t_channel_messages.count,t_channel_messages.chmessage,t_channel_messages.created_at,t_channel_messages.updated_at")
                             .joins("join m_users on m_users.user_id=t_channel_messages.chsender_id")
                             .where("channel_id=?", session[:clickchannel_id]).order("t_channel_messages.created_at ASC")
    @chmesg.each { |thread|
      @thredcount = HChmessageReply.select("*")
                                   .joins("join t_channel_messages on t_channel_messages.chmsg_id=h_chmessage_replies.chmsgid")
                                   .where("h_chmessage_replies.chmsgid=?", thread.chmsg_id)
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
  end

  #To edit the users (add or remove)
  def memberedit
    main
    @clickchannel = MChannel.find_by("channel_id=?", session[:clickchannel_id])
    @m_clickuser = MUser.select("*").joins("join m_channels on m_channels.user_id=m_users.user_id").where("m_channels.channel_name=? and m_channels.workspace_id=?", session[:clickchannel_name], session[:workspace_id])
    #@count = MChannel.select("*").where("workspace_id=? and channel_name=?",session[:workspace_id],session[:clickchannel_name])
    #@currentcount = (@count.size).to_s
    @count = MChannel.select("*")
                     .where("workspace_id=? and channel_id=?", session[:workspace_id], session[:clickchannel_id])
    @chmembercount = (@count.size).to_s
    @chadmin = MChannel.select("*")
                       .joins("join m_users on m_channels.user_id=m_users.user_id")
                       .where("m_channels.channel_name=? and m_channels.workspace_id=? and m_channels.chadmin = 1", session[:clickchannel_name], session[:workspace_id])
    @chnotadmin = MChannel.select("*")
                          .joins("join m_users on m_channels.user_id=m_users.user_id")
                          .where("m_channels.channel_name=? and m_channels.workspace_id=? and m_channels.chadmin != 1", session[:clickchannel_name], session[:workspace_id])

    @chnotadmin = @chnotadmin.paginate(page: params[:page], per_page: 10)
  end

  #for messages send button
  def message
    mention_name = params[:channel][:memtion_name]
    mention_name[0] = ""
    mention_u = MUser.find_by(user_name: mention_name)

    @t_chmsg = TChannelMessage.new

    @t_chmsg.chsender_id = session[:user_id]
    @t_chmsg.channel_id = session[:clickchannel_id]
    @t_chmsg.chmessage = params[:channel][:chmessage]
    if mention_u
      @t_mention = TMention.new
      @t_mention.mentioned_id = mention_u.user_id
      @t_mention.login_user_id = session[:user_id]
      @t_mention.workspace_id = session[:workspace_id]
      @t_mention.mention_message = params[:channel][:chmessage]
      @t_mention.chmsgmen_id = session[:clickchannel_id]
      @t_mention.save
    end
    @t_chmsg.save
    main
    @chmsg = TChannelMessage.find_by("chsender_id=? and channel_id=? and chmessage=?", session[:user_id], @t_chmsg.channel_id, @t_chmsg.chmessage)
    @clickchannel = MChannel.find_by("channel_id=?", session[:clickchannel_id])
    @m_clickuser = MUser.joins("join m_channels on m_channels.user_id=m_users.user_id")
                        .where("m_channels.channel_name=? and m_channels.workspace_id=?", session[:clickchannel_name], session[:workspace_id])
    @m_clickuser.each { |chuser|
      @tchmsg = TChunreadMessage.new
      @tchmsg.chmsg_id = @chmsg.chmsg_id
      @tchmsg.chuser_id = chuser.user_id
      if chuser.user_id == session[:user_id]
        @tchmsg.is_read = 0
      else
        @tchmsg.is_read = 1
      end
      @tchmsg.save
    }
    redirect_back(fallback_location: chmessage_path)
  end

  #To delete channel messages
  def chmessagedelete
    TChannelMessage.where("chmsg_id=?", params[:messagedelete]).delete_all
    redirect_back(fallback_location: chmessage_path)
  end

  #To show mention users who was mentioned log-in user
  def mention
    memberedit
    @men = TMention.select("*")
                   .joins("join m_users on m_users.user_id=t_mentions.login_user_id join m_channels on m_channels.channel_id=t_mentions.chmsgmen_id")
                   .where("t_mentions.mentioned_id=? and t_mentions.workspace_id=? and m_channels.user_id=?", session[:user_id], session[:workspace_id], session[:user_id])
  end

  #To manage channel from current workspace
  def managechannel
    main
    #@chmesg=TChannelMessage.select("*").joins("join m_users on m_users.user_id=t_channel_messages.chsender_id").where("channel_id=?",session[:clickchannel_id]).order("t_channel_messages.created_at ASC")
    @curworchannel = MChannel.joins("join m_workspaces on m_workspaces.workspace_id = m_channels.workspace_id and m_channels.user_id = m_workspaces.user_id ")
      .where("m_workspaces.workspace_id=? and m_channels.user_id=? and m_channels.chadmin= 1", session[:workspace_id], session[:user_id])
    @curworchannel = @curworchannel.paginate(page: params[:page], per_page: 13)
  end

  #To create new channel
  def create
    @channel = MChannel.new()
    if params[:session][:channelname].blank?
      flash[:danger] = "Write your channel name!"
      redirect_to channel_path
    else
      @channel.user_id = session[:user_id]
      @channel.workspace_id = session[:workspace_id]
      @channel.channel_name = params[:session][:channelname]
      @channel.chadmin = 1
      if params[:channeltype] == "private"
        @channel.status = 0
      else
        @channel.status = 1
      end
      @w = MChannel.select("*").where("workspace_id=?", session[:workspace_id])
      @ary = Array.new
      @w.each { |w|
        @ary.push(w.channel_name)
      }
      if !@ary.include?(params[:session][:channelname])
        @channel.save
        redirect_to home_path
      else
        flash[:danger] = "Channel Name is already taken!"
        redirect_to channel_path
      end
    end
  end

  def pubchannelshow
    channelchat
  end

  def pubchmember
    memberedit
  end
end
