class AffiliatesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_after_action :verify_authorized

  def show
    @affiliate = Affiliate.find_by_name(params[:name])
    @affiliates = Affiliate.all
  end
end
