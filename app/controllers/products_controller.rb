class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :find_product, only: [ :edit, :update, :destroy, :show ]

  def index
  end

  def show
    authorize @product
    i = @product.nb_of_searches + 1
    @product.update(nb_of_searches: i)
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to admin_dashboard_path
    else
      render new_product_path
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product

    @product.update(product_params)

    redirect_to product_path(@product)
  end

  def destroy
    authorize @product
    @product.destroy

    redirect_to admin_dashboard_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :reference, :category, :price, :characteristics,
                                    :description, :deposit, :technical_sheet,
                                    :photo, :video, :loxam_link)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
