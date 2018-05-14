class CategoriesController < ApplicationController
  before_action :find_category, only: [ :show ]
  skip_before_action :authenticate_user!, only: [ :show ]

  def show
    @products = Product.where(category_id: params[:id])
    authorize @products
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_category
    @category = Category.find_by_name(params[:name])
  end
end
