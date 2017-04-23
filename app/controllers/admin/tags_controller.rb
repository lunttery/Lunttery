class Admin::TagsController < Admin::BaseController

  def index
    @tags = Tag.all.page(params[:page]).per(10)
  end

end
