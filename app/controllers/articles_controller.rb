class ArticlesController < ApplicationController
    before_action :set_article, only:[:edit, :update, :show, :destroy]
    def index
    @articles =Article.all
    end
    def new
        @article =Article.new 
    end
def edit

end

    def create
        @article = Article.new(article_params)
        #if items and description are empty it will go to new.html
        if @article.save
                       #display a notice
            flash[:success] = "Article was successfully created."
            redirect_to article_path (@article)
        else
           render(:new , status: :unprocessable_entity) 
         end
    end
    def update
       
        if @article.update(article_params)
            flash[:success] = "Article is updated successfully"
            redirect_to article_path(@article)

        else
            render(:edit , status: :unprocessable_entity)
        end
    end
    
    def show
       
    end
    def destroy
    
    @article.destroy
    flash[:danger] = "Article is deleted successfully"
    redirect_to articles_path
    end

    
    private
    def set_article
        @article =Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit( :title,:description)
    end

end
