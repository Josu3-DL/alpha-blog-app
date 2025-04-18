class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]

    def index
        @articles = Article.all
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
        @article.user = User.first
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
    
end