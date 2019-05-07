class PromosController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :find_promo, only: [ :show, :edit, :update, :destroy ]

  def create
    @promo = Promo.new(promo_params)
    authorize @promo
    respond_to do |format|
      if @promo.save
        redirect_to '/'
      else
        redirect_to '/'
      end
    end
  end

  def edit
    authorize @promo
  end

  def update
    authorize @promo
    respond_to do |format|
      if @promo.update(promo_params)
        redirect_to '/'
      else
        redirect_to '/'
      end
    end
  end

  def destroy
    authorize @promo
    respond_to do |format|
      if @promo.destroy
        redirect_to '/'
      else
        redirect_to '/'
      end
    end
  end

  private

  def promo_params
    params.require(:promo).permit(:title, :description, :media)
  end

  def find_promo
    @promo = Promo.find(params[:id])
  end
end
