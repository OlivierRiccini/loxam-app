class CatalogsController < ApplicationController
  # def create
  #   @catalog = Catalog.new(catalog_params)

  #   catalog_type = catalog_params[:catalog_type]

  #   if @catalog.save
  #     redirect_to "#{@catalog.catalog_type}"_path
  #   else
  #     render admin_dashboard_path
  #   end
  # end

  def update
    @catalog = Catalog.find(params[:id])
    catalog_type = params[:catalog][:catalog_type]
    authorize @catalog

    if @catalog.update(catalog_params)
      redirect_to "/#{catalog_type}"
    else
      render admin_dashboard_path
    end
  end

  private

  def catalog_params
    params.require(:catalog).permit(:catalog_type, :link, :image)
  end

end
