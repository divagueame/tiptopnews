class NewspapersController < ApplicationController
  def index
    @newspapers = Newspaper.all
  end

  def show
    @newspaper = Newspaper.find(params[:id])
  end

  def new
    @newspaper = Newspaper.new
  end

  def create
    @newspaper = Newspaper.new(newspaper_params)

    if @newspaper.save
      redirect_to @newspaper
    else
      render :new
    end
  end

  def edit
    @newspaper = Newspaper.find(params[:id])
  end

  def update
    @newspaper = Newspaper.find(params[:id])

    if @newspaper.update(newspaper_params)
      redirect_to @newspaper
    else
      render :edit
    end
  end

  def destroy
    @newspaper = Newspaper.find(params[:id])
    @newspaper.destroy

    redirect_to root_path
  end

  def crawl  
 
      Newspaper.all.each do |newspaper|
        thisUrl = newspaper.newspaperUrl 
        html = URI.open("#{thisUrl}").read 
        header = Nokogiri::HTML(html)  
        headers = header.css(newspaper.newspaperCssSelector)
        urlAppend =  headers[0].attribute('href').value
        retrievedArticleHeadline = headers[0].content; 
        retrievedArticleUrl = thisUrl + urlAppend 
      @article = Article.new(headline: retrievedArticleHeadline, url: retrievedArticleUrl, newspaper_id: newspaper.id)
      # p @article.valid?
      if(@article.save)then p "Article saved!" else p "Article not saved. It's already in the db!" end 
       
    end





  end
  private

  def newspaper_params
    params.require(:newspaper).permit(:newspaperName, :newspaperUrl, :newspaperCssSelector, :newspaperArticleUrlAppend)
  end
end
