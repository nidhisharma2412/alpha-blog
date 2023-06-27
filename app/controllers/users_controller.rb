class UsersController < ApplicationController
def index
@users = User.paginate(page: params[:page], per_page: 5)
#@user = User.all
end
def create
@user=User.new
end

def edit

end
def show
    @user = User.find(params[:id])
    @user_articles= @user.articles.paginate(page: params[:page], per_page: 5)
end

private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end