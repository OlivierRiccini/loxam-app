class PagesController < ActionController::Base
  def home
    @products = Product.all
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
end
