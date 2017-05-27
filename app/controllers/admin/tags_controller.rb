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

  def edit

  end

  def update
    if @tag.update(permit_tag)
      flash[:notice] = "編輯成功"
      redirect_to admin_tags_path
    else
      flash[:alert] = "編輯失敗"
      render :edit
    end
  end

  def destroy
    @tag.destroy

    flash[:notice] = "刪除成功"
    redirect_to admin_tags_path
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def permit_tag
    params.require(:tag).permit(:name, :source_type)
  end
end
