class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :all_categories, :all_products
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit
  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company, :avatar])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:company, :avatar])
  end

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def all_categories
    @categories = Category.order('name ASC')
  end

  def all_products
    @products = Product.order('name ASC')
  end

  def authenticate_user!
    unless current_user || (params[:controller] == "devise/registrations" || params[:controller] == "devise/sessions")
      render 'layouts/authenticate_error.js'
      flash[:error] = "Vous devez être connecté pour pouvoir effectuer cette action"
    end
  end
end
