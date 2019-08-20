class UsersController < ApplicationController

  # def show
  # @m_user = MUser.find(params[:id])
  # end
  #def join

  # end

  #To show signup page
  def new
    @m_user = MUser.new
  end

  #for creating new user,when click signup button
  def create
    @m_user = MUser.new(user_params)
    if @m_user.save
      log_in @m_user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to workspacecreate_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:m_user).permit(:user_name, :user_email, :password,
                                   :password_confirmation)
  end
end
