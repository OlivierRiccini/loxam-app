class CategoriesController < ApplicationController
  before_action :find_category_by_name, only: [ :show ]
  before_action :find_category, only: [ :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :show ]

  def show
    @products = Product.where(category_id: @category.id).order('name ASC')
    authorize @products
    @categories = Category.order('name ASC').all
    # @all_products = Product.order('name ASC').all
    # @new_favorite = Favorite.new
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    respond_to do |format|
      if @category.save
        format.js
      else
        format.js
      end
    end
  end

  def update
    authorize @category
    respond_to do |format|
      if @category.update(category_params)
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @category.destroy
    authorize @category
    respond_to do |format|
      if @category.destroy
        format.js
      else
        format.js
      end
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def find_category_by_name
    @category = Category.find_by_name(params[:name])
  end


  def category_params
    params.require(:category).permit(:name)
  end
end
