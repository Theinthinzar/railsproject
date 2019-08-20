class DirmsgstarController < ApplicationController

  #when click star button,the message will save into t_directstars table
  def new
    @t_dstar = TDirectstar.new
    @t_dstar.star_userid = session[:user_id]
    @t_dstar.stardimsg_id = params[:clickdstarid]  
    @t_dstar.save    
    redirect_back(fallback_location: dirmsgstar_path)
  end

  #when click unstar button, the message will delete from t_directstars table
  def dirunstar
    TDirectstar.find_by("stardimsg_id=?", params[:unstarid]).delete
    redirect_back(fallback_location: dirmsg_path)
  end
end
