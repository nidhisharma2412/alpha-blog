class ArticlesController < ApplicationController
    def new
        @article =Article.new 


    end
    def create
        
        @article = Article.new(article_params)
        #if items and description are empty it will go to new.html
        if @article.save
            format.html{
                redirect_to article_path(@article)
            }
            #display a notice

            #flash[:notice] = "Article was successfully created."
            #redirect_to article_path (@article)
              
        else
         
                       render (:new ) 
          
         end
    end

    def show
    
    end

    private
    def article_params
        params.require(:article).permit( :title,:description)
    end

end
