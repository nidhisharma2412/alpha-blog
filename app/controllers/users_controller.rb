class UsersController < ApplicationController
    before_action :require_same_user, only:[:edit, :update, :destroy]
    before_action :require_admin , only:[:destroy]


    def index
      @users = User.paginate(page: params[:page], per_page: 5)
      #@user = User.all
    end
def create
  @user=User.new
  if @user.save
    session[:user_id] = @user.id
    flash[:successs] = "Welcome to Alpha Blog #{@user.username}"
    redirect_to user_path(@user)
  else
    render 'new'
  end
end

def edit

end

def show
    @user = User.find(params[:id])
    @user_articles= @user.articles.paginate(page: params[:page], per_page: 5)
end
def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles have been deleted"
    redirect_to users_path
end

private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

def require_same_user
   if current_user != @user and !current_user.admin?
        flash[:danger]= "you can only edit your own account"
        redirect_to root_path
    end
end



def require_admin
    if user_signed_in? and !current_user.admin?
        flash[:danger] = "Only admin can perform that action"
        redirect_to root_path
    end
    
end
end



