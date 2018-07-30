class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :find_product, only: [ :show, :edit, :update, :destroy ]

   # include ActionView::Helpers::UrlHelper

  def show
    authorize @product
    i = @product.nb_of_searches + 1
    @product.update(nb_of_searches: i)
    @categories = Category.all
    @products = Product.all

    @message = Message.new
    # @new_favorite = Favorite.new
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
    if @product.update(product_params)
      if request.referrer.include? admin_dashboard_path
        respond_to { |format| format.js }
      else
        redirect_to product_path(@product)
      end
    else
      if request.referrer.include? admin_dashboard_path
        respond_to { |format| format.js }
      else
        render edit_product_path(@product)
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
    params.require(:product).permit(:name, :reference, :category_id, :price, :pricing, :features,
                                    :description, :deposit, :technical_sheet, :photo, :video,
                                    :loxam_link, :best_searches_choice, :new_product_choice)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
