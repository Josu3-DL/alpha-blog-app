class SessionsController < ApplicationController
    def new

    end

    def create
        user = User.find_by(email: params[:email.downcase])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:notice] = "Welcome #{user.username}"
            redirect_to articles_path
        else
            flash.now[:alert] = "Something was wrong"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path
    end
end
