class Admin::TagsController < Admin::BaseController
  before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all.page(params[:page]).per(10)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(permit_tag)

    if @tag.save
      flash[:notice] = "新增成功"
      redirect_to admin_tags_path
    else
      flash[:alert] = "新增失敗"
      render :new
    end
  end

  private

  def permit_tag
    params.require(:tag).permit(:name, :source_type)
  end
end
