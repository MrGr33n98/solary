class SubcategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:category_id])
    @subcategory = @category.subcategories.friendly.find(params[:id])
  end

  def index
    @category = Category.friendly.find(params[:category_id])
    @subcategories = @category.subcategories
  end
end
