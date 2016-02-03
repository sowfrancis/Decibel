class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end


  private

  def params_tag
    params.require(:tag).permit(:name)
  end
end
