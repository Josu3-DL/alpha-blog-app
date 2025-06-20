class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destory]
    
    def index
        @articles = Article.paginate(page: params[:page], per_page: 2)
    end
    
    def show
    end

    def new
        @article = Article.new
    end

    def edit
        
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "The article was updated succesfully"
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def create
        @article = Article.create(article_params)
        @article.user = User.find(session[:user_id])
        if @article.save
            flash[:notice] = "The article was saved succesfully"
            redirect_to @article
        else
            render :new, status: :unprocessable_entity #el status es importante para poder renderizar los errores
        end
    end

    def destroy
        if @article.destroy
            flash[:notice] = 'Object was deleted successfully'
            redirect_to articles_path
        else
            render :index
        end
    end

    private
    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title,:description)
    end
    
    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in"
            redirect_to articles_path
        end
    end

    def require_same_user
        if current_user != @article.user
            flash[:notice] = "You only can do this action for your own article."
            redirect_to articles_path
        end
    end
end