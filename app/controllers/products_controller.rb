class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :find_product, only: [ :show, :edit, :update, :destroy ]

  def show
    authorize @product
    i = @product.nb_of_searches + 1
    @product.update(nb_of_searches: i)
    @categories = Category.all
    @products = Product.all

    @message = Message.new
    @new_favorit = Favorit.new
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    respond_to do |format|
      if @product.save
        format.js
      else
        format.js
      end
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product
    respond_to do |format|
      if @product.update(product_params)
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    authorize @product
    respond_to do |format|
      if @product.destroy
        format.js
      else
        format.js
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :reference, :category_id, :price, :features,
                                    :description, :deposit, :technical_sheet, :photo, :video,
                                    :loxam_link, :best_searches_choice, :new_product_choice)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
