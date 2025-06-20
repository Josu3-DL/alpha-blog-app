class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_user only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update]
    
    def index
        @users = User.paginate(page: params[:page], per_page: 2)
    end

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "You have signed up successfully #{@user.username}"
            redirect_to articles_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
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

    def set_user
        @user = User.find(params[:id])
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You most be logged in"
            redirect_to root_path
        end
    end

    def require_same_user
        if current_user != @user
            flash[:notice] = "You can only do this action for your own user"
            redirect_to root_path
        end
    end
end
