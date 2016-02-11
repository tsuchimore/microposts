class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  def edit
    unless current_user == @user
      redirect_to root_path
    end     
  end
  
  def update
 
    if current_user == @user
      if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
      else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
      end
    else
      redirect_to root_path
    end
  end
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end



  private

  def user_params
    params.require(:user).permit(:name, :age, :email, :password,
                                 :password_confirmation)
  end
  
  
  
end
