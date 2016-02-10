class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def new
    @tags = Tag.all
    @tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
  end


  private

  def params_tag
    params.require(:tag).permit(:name)
  end
end
