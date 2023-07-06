class ArticlesController < ApplicationController
    
    before_action :set_article, only:[:edit, :update, :show, :destroy]
    before_action :require_user, except:[:index, :show]
    before_action :require_same_user, only:[:edit, :update, :destroy]

    def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
    end
    def new
        @article = Article.new 
    end
def edit

end

    def create
        @article = Article.new(article_params)
        @article.user = User.first
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

    def require_user
        if !user_signed_in? 
            flash[:danger] = "you must be logged in before that action "
            redirect_to root_path
        end
        end
    
    def require_same_user
        if current_user != @article.user and !current_user.admin?
            flash[:danger] = "You can only delete or edit your own article"
            redirect_to root_path
        end
    end
    
    private
    def set_article
        @article =Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit( :title,:description)
    end


end
