class PagesController < ApplicationController
  before_action :all_products, only: [ :home, :mon_espace, :admin_dashboard ]
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def mon_espace
    @user = current_user
    @documents = Document.where(user_id: @user.id)

    @products = []

    @documents.each do |document|
      document.transactions.each do |transaction|
        @products << Product.find(transaction.product_id)
      end
    end

    popular_products = @products.each_with_object(Hash.new(0)) do
      |m,h| h[m] += 1
    end
    @popular_products = popular_products.sort_by{ |k,v| v }.last(5).reverse
  end

  def admin_dashboard
    @user = current_user
    authorize @user
    @users = User.all

    @lines = []

    # File.open("http://res.cloudinary.com/dto9foc0m/raw/upload/v1523893819/test.TXT", "r").each do |line|
    #   @lines << line
    # end

    text = Net::HTTP.get( URI.parse( "http://res.cloudinary.com/dto9foc0m/raw/upload/v1523893819/test.TXT" ) )
    text.split("\n").each do |line|
      @lines << line.split(" ")
    end
  end

  def location
  end

  def vente
  end

  def reparation
  end

  def contact
  end

  def minilease
  end

  def garantie_dommages
  end

  def conditions_generales_de_location
  end

  def conditions_generales_de_vente
  end

  def documentations
  end

  private

  def all_products
    @products = Product.all
  end
end
