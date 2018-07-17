class FavoritesController < ApplicationController
  def create
    @new_favorite = Favorite.new(favorite_params)
    @new_favorite.user_id = current_user.id
    authorize @new_favorite

    if @new_favorite.save
      product = Product.where(id: @new_favorite.product_id).take
      i = product.present_in_favorites + 1
      product.update(present_in_favorites: i)
      redirect_to mon_espace_path
    else
      product = Product.where(id: params[:product_id])
      render product_path(product)
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
