class ExpendablesController < ApplicationController
  def create
    raise
    product_id = params[:product]
  end

  def update
  end

  def destroy
  end

  private

  def expendables_params
    params.require(:expendable).permit(:reference, :price, :description)
  end
end
