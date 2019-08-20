require "will_paginate/array"
class StaticPagesController < ApplicationController
  #To show welcome page
  def welcome
  end

  def workspacehome
  end

  def workspacecreate
  end

  #To show home page
  def home
    main
    #@pubarray = Array.new
    #@m_channel.each { |r|
      #@pubarray.push(r.channel_name)
    #}
    #@public_channel_list = MChannel.select("distinct m_channels.channel_name,m_channels.channel_id")
                                   #.joins("join m_workspaces on m_workspaces.workspace_id = m_channels.workspace_id  ")
                                   #.where(" m_channels.status=1 and m_workspaces.workspace_id=? and m_channels.user_id!=?", session[:workspace_id], session[:user_id])
  end

  #To update is_read's value 1 to 0 into t_dirmessages and t_chunread_messages
  def update
    TDirmessage.where("receiver_user_id=? and dirworkspace_id=?", session[:user_id], session[:workspace_id]).update_all(is_read: 0)
    TChunreadMessage.joins("join t_channel_messages on t_channel_messages.chmsg_id=t_chunread_messages.chmsg_id")
                    .where("chuser_id=? ", session[:user_id]).update_all(is_read: 0)
    redirect_back(fallback_location: update_path)
  end

  #star button for showing starmessages
  def starmessage
    main
    @dstar = TDirmessage.select("m_users.user_name,t_dirmessages.dir_message,t_dirmessages.created_at")
                        .joins("join m_users on m_users.user_id=t_dirmessages.sender_user_id join t_directstars on t_directstars.stardimsg_id=t_dirmessages.dirmsg_id")
                        .where("dirworkspace_id=? and t_directstars.star_userid=?", session[:workspace_id], session[:user_id]).order("t_dirmessages.created_at ASC")
    @dstar = @dstar.paginate(page: params[:page], per_page: 3)

    #@dirmesg = TDirmessage.select("m_users.user_name,t_dirmessages.dir_message,t_dirmessages.created_at")
                          #.joins("join m_users on m_users.user_id=t_dirmessages.sender_user_id")
                          #.where("dirworkspace_id=? and ((receiver_user_id=? and sender_user_id=?)||(t_dirmessages.receiver_user_id=? and t_dirmessages.sender_user_id=?))", session[:workspace_id], session[:user_id], params[:clickuserid], params[:clickuserid], session[:user_id]).order("t_dirmessages.created_at ASC")
    @clickchannel = MChannel.find_by("channel_id=?", session[:clickchannel_id])
    #@star = TChannelMessage.select("m_users.user_name,t_dirmessages.dir_message,t_dirmessages.created_at")
                           #.joins("join m_users on m_users.user_id=t_dirmessages.sender_user_id join t_directstars on t_directstars.stardimsg_id=t_dirmessages.dirmsg_id")
                           #.where("dirworkspace_id=? and t_directstars.star_userid=?", session[:workspace_id], session[:user_id]).order("t_dirmessages.created_at ASC")
    @chstar = TChannelMessage.select("m_channels.channel_name ,m_users.user_name ,t_channel_messages.chmessage,t_channel_messages.created_at")
                             .joins("join m_users on t_channel_messages.chsender_id=m_users.user_id join t_chmsgstars on t_chmsgstars.chmsgstarid=t_channel_messages.chmsg_id join m_channels on m_channels.channel_id=t_channel_messages.channel_id")
                             .where(" t_chmsgstars.chstar_userid=? and m_channels.user_id = ? and m_channels.workspace_id=? ", session[:user_id], session[:user_id], session[:workspace_id])
    @chstar = @chstar.paginate(page: params[:page], per_page: 3)
  end

  #for showing unread messages, when click unread button
  def unread
    home
    #@dirmesg = TDirmessage.select("m_users.user_name,t_dirmessages.dir_message,t_dirmessages.created_at")
                          #.joins("join m_users on m_users.user_id=t_dirmessages.sender_user_id")
                          #.where("dirworkspace_id=? and ((receiver_user_id=? and sender_user_id=?)||(t_dirmessages.receiver_user_id=? and t_dirmessages.sender_user_id=?))", session[:workspace_id], session[:user_id], params[:clickuserid], params[:clickuserid], session[:user_id]).order("t_dirmessages.created_at ASC")
    @clickchannel = MChannel.find_by("channel_id=?", session[:clickchannel_id])

    @m_clickchuser = MUser.joins("join m_channels on m_channels.user_id=m_users.user_id")
                          .where("m_channels.channel_name=? and m_channels.workspace_id=?", session[:clickchannel_name], session[:workspace_id])

    @dirmsg = TDirmessage.select("m_users.user_name,t_dirmessages.dir_message,t_dirmessages.created_at")
                         .joins("join m_users on m_users.user_id=t_dirmessages.sender_user_id")
                         .where("dirworkspace_id=? and receiver_user_id=? and is_read=1", session[:workspace_id], session[:user_id])
    @chmesg = TChannelMessage.select("m_channels.channel_name ,m_users.user_name ,t_channel_messages.chmessage,t_channel_messages.created_at")
                             .joins("join m_users on t_channel_messages.chsender_id=m_users.user_id join t_chunread_messages on t_chunread_messages.chmsg_id=t_channel_messages.chmsg_id join m_channels on m_channels.channel_id=t_channel_messages.channel_id")
                             .where("t_chunread_messages.is_read =1 and t_chunread_messages.chuser_id=? and m_channels.user_id=? and m_channels.workspace_id=? ", session[:user_id], session[:user_id], session[:workspace_id])
  end
end
