class FavoritesController < ApplicationController
  def create
    @new_favorite = Favorite.new(favorite_params)
    @new_favorite.user_id = current_user.id
    authorize @new_favorite
    # if current_page?(admin_dashboard_path)
    #  raise
    # end
    respond_to do |format|
      if @new_favorite.save
        product = Product.where(id: @new_favorite.product_id).take
        i = product.present_in_favorites + 1
        product.update(present_in_favorites: i)
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @favorite = Favorite.where(product_id: params[:id]).take
    authorize @favorite
    product = Product.find(params[:id])
    i = product.present_in_favorites - 1
    product.update(present_in_favorites: i)
    @favorite.destroy
    redirect_to mon_espace_path
  end

  private

  def favorite_params
    params.permit(:product_id)
  end
end
