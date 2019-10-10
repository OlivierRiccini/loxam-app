class ProductsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :find_product, only: [ :edit, :update, :destroy ]
  before_action :find_product_by_name, only: :show
   # include ActionView::Helpers::UrlHelper

  def show
    authorize @product
    i = @product.nb_of_searches + 1
    @product.update(nb_of_searches: i)
    # @categories = Category.all
    @products = Product.all

    @message = Message.new
    # @new_favorite = Favorite.new
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    # respond_to do |format|
    @product.name.gsub!('.', ',')
    if @product.save
      redirect_to product_name_path(@product.slug)
    else
      render admin_dashboard_path
    end
    # end
  end

  def edit
    authorize @product
    @product.expendables.build
  end

  def update
    authorize @product
    if @product.update(product_params)

      # Removing '.' because of routing issue
      @product.name.gsub!('.', ',')
      @product.slug.gsub!(' ', '-')

      if params[:remove_features]
        @product.remove_features!
      end

      if params[:remove_technical_sheet]
        @product.remove_technical_sheet!
      end

      @product.save
      if request.referrer.include? admin_dashboard_path
        respond_to { |format| format.js {flash[:success] = "#{@product.name} a été modifié"} }
      else
        redirect_to product_name_path(@product.slug)
      end
    else
      if request.referrer.include? admin_dashboard_path
        respond_to { |format| format.js {flash[:success] = "#{@product.name} n'a pas pu être modifié"} }
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
                                    :remove_features, :remove_technical_sheet,
                                    :loxam_link, :best_searches_choice, :new_product_choice,
                                    expendables_attributes: Expendable.attribute_names.map(&:to_sym).push(:_destroy))
  end

  def find_product
    @product = Product.friendly.find(params[:id])
  end

  def find_product_by_name
    @product = Product.friendly.find(params[:slug])
  end
end
