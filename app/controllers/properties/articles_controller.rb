class Properties::ArticlesController < ApplicationController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def index
    if @property.articles.blank?
      redirect_to new_property_article_path(@property)
    else
      @articles = @property.articles.decorate
    end
  end

  def show
    @article = @property.articles.where(id: params[:id]).first.decorate
  end

  def new
    @article = Article.new.decorate
  end

  def create
    @article = Article.new params[:article].merge(source_id: @property.id, source_type: 'property')

    if @article.save
      redirect_to(property_article_path(@property, @article), notice: 'Article was successfully created.')
    else
      @article = @article.decorate
      render action: 'new'
    end
  end

  def edit
    @article = @property.articles.where(id: params[:id]).first.decorate
  end

  def update
    @article = @property.articles.where(id: params[:id]).first

    if @article.update_attributes params[:article]
      redirect_to(property_article_path(@property, @article), notice: 'Article was successfully updated.')
    else
      @article = @article.decorate
      render action: 'edit'
    end
  end

  def destroy
    @article = @property.articles.where(id: params[:id]).first
    @article.destroy

    render text: "<script> Rentify.content.setHtmlFromRemote({ url: '#{ property_articles_path(@property) }'}); </script>"
  end

private

  def load_property
    @property = Property.find(params[:property_id])
  end

  def check_if_property_belongs_to_user
    if @property.user != current_user
      redirect_to root_path
    end
  end
end
