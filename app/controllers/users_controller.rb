class UsersController < ApplicationController
    def index
        @users = User.paginate(page: params[:page], per_page: 2)
    end

    def show
        @user = User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "You have signed up successfully #{@user.username}"
            redirect_to articles_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "The profile was updated succesfully"
        redirect_to @user
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
