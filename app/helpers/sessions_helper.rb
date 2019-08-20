module SessionsHelper
  def log_in(m_user)
    session[:user_id] = m_user.user_id
    session[:user_name] = m_user.user_name
  end

  def current(m_work)
    session[:workspace_id] = m_work.workspace_id
    session[:workspace_name] = m_work.workspace_name
    session[:workspace_admin] = m_work.admin
  end

  def channelthread(chthread)
    session[:chthread_id] = chthread.chmsg_id
  end

  def directthread(dirthread)
    session[:dirthread_id] = dirthread.dirmsg_id
  end

  def user_current(user)
    session[:current_id] = user.user_id
    session[:current_name] = user.user_name
  end

  def clickuser(click_user)
    session[:clickuser_id] = click_user.user_id
    session[:clickuser_name] = click_user.user_name
  end

  def clickchannel(click_channel)
    session[:clickchannel_id] = click_channel.channel_id
    session[:clickchannel_name] = click_channel.channel_name
    session[:clickchannel_status] = click_channel.status
  end

  def current_user
    if session[:user_id]
      @current_user ||= MUser.find_by(user_id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
