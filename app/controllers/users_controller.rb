class UsersController < ApplicationController

def create

end

def edit
@user =  User.new
end
def show
    @user = User.find(params[:id])
end

private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end