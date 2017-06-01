class UsersController < ApplicationController
  before_action :require_login, only:[:show]

  def create
    @user= User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email],password: params[:password])
    if @user.valid?
      session[:user_id]= @user.id
      redirect_to "/shoes"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end
  def show
    @user = User.find(session[:user_id])
    @products = Product.all
    @purchased= Buyer.where('user_id=?', current_user.id)
    @sold_items = Buyer.all
    @my_products = Product.where('user_id=?', current_user.id)
    @unsold = []
    @total = 0
    @total_s = 0
    @my_products.each do |shoe|
      if Buyer.all.where('product_id=?', shoe.id).length == 0
        @unsold << shoe
      end
    end
  end
end
