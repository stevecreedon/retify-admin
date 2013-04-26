class Api::Properties::ArticlesController < ApiController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def new
    render json: Article.new
  end

  def create
    @article = Article.new params[:article].merge(source_id: @property.id, source_type: 'property')

    if @article.save
      if @article.group == 'terms'
        current_user.feeds.where( feed_type: :create_property_terms_page ).destroy_all
      elsif @article.group == 'availability'
        current_user.feeds.where( feed_type: :create_property_availability_page ).destroy_all
      end

      render json: @article, status: 200
    else
      render json: @article, status: 400
    end
  end

  def update
    article = @property.articles.where( id: params[:id] ).first

    if article.update_attributes(params[:article])
      if article.group == 'terms'
        current_user.feeds.where( feed_type: :create_property_terms_page ).destroy_all
      elsif article.group == 'availability'
        current_user.feeds.where( feed_type: :create_property_availability_page ).destroy_all
      end

      render json: article, status: 200
    else
      render json: article, status: 400
    end
  end

private 

  def load_property
    @property = Property.find(params[:property_id])
  end

  def check_if_property_belongs_to_user
    render json: { error: 'access denied' }, status: 401 unless @property.user.id == current_user.id
  end
end
