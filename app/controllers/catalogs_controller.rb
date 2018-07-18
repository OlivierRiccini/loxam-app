class CatalogsController < ApplicationController
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
