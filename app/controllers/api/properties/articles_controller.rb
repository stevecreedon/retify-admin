class Api::Properties::ArticlesController < ApiController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def new
    render json: Article.new
  end

  def create
    @article = Article.new params[:article].merge(source_id: @property.id, source_type: 'property')

    status = @article.save ? 200 : 400
    render json: @article, status: status
  end

private 

  def load_property
    @property = Property.find(params[:property_id])
  end

  def check_if_property_belongs_to_user
    render json: { error: 'access denied' }, status: 401 unless @property.user.id == current_user.id
  end
end
