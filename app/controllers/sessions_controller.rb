class SessionsController < ApplicationController
  def index
  end
    def create
      @user= User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        session[:user_id]= @user.id
        redirect_to "/shoes"
      else
        flash[:errors] = @user.errors.full_messages unless @user==nil
        redirect_to :back
      end
    end
    def logout
      session[:user_id]= nil
      redirect_to '/'
    end
end
