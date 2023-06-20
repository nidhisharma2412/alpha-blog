class ArticlesController < ApplicationController
    
    def index
    @articles =Article.all
    end
    def new
        @article =Article.new 
    end
def edit
 @article =Article.find(params[:id])
end

    def create
        @article = Article.new(article_params)
        #if items and description are empty it will go to new.html
        if @article.save
                       #display a notice
            flash[:notice] = "Article was successfully created."
            redirect_to article_path (@article)
        else
           render(:new , status: :unprocessable_entity) 
         end
    end
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = "Article is updated successfully"
            redirect_to article_path(@article)

        else
            render(:edit , status: :unprocessable_entity)
        end
    end
    
    def show
        @article =Article.find(params[:id])
    end
    def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article is deleted successfully"
    redirect_to articles_path
    end

    
    private
    def article_params
        params.require(:article).permit( :title,:description)
    end

end
