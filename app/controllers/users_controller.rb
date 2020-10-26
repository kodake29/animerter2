class UsersController < ApplicationController

  before_action :login_check

  def show
    @user = User.find(params[:id])
    if @user.id == current_user.id
       @reviews = @user.reviews.page(params[:page]).reverse_order.where(release_status: 0).per(5)
    else
      @reviews = @user.reviews.page(params[:page]).reverse_order.where(release_status: 0, private_status: 0).per(5)
    end
    @my_lists = MyList.page(params[:my_list_page]).reverse_order.where(user_id: @user.id).per(8)
  end


  def edit
  	@user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  def confirmation
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(withdrawal_status: 1)
    reset_session
    redirect_to "/"
  end

  private
  def user_params
    params.require(:user).permit(:name, :image, :withdrawal_status)
  end

  def login_check
    unless user_signed_in?
      flash[:alert] = "サービスをご利用いただくにはログインが必要です。"
      redirect_to root_path
    end
  end

end
