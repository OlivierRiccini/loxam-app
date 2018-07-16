class CatalogsController < ApplicationController
  def create
    @catalog = Catalog.new(catalog_params)

    catalog_type = catalog_params[:type]

    if @catalog.save
      redirect_to "#{catalog_type}"_path
    else
      render admin_dashboard_path
    end
  end

  def update
    @catalog = Catalog.find(params[:id])
    catalog_type = catalog_params[:type]

    if @catalog.update(catalog_params)
      redirect_to "#{catalog_type}"_path
    else
      render admin_dashboard_path
    end
  end

  private

  def catalog_params
    params.require(:catalog).permit(:catalog_type, :link, :image)
  end

end
