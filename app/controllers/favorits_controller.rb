class FavoritsController < ApplicationController
  def create
    @new_favorit = Favorit.new(user_id: current_user.id)
    # @new_favorit.user_id = current_user.id
    authorize @new_favorit

    if @new_favorit.save
      redirect_to mon_espace_path
    else
      render product_path(Product.find(params[:product_id]))
    end
  end

  def destroy
    @favorit = Favorit.find(params[:id])
    @favorit.destroy
    redirect_to mon_espace_path
  end

  # private

  # def favorit_params
  #   params.require(:favorit).permit(:user_id)
  # end
end
