class PagesController < ApplicationController
  before_action :all_products, only: [ :home, :mon_espace, :admin_dashboard ]
  skip_before_action :authenticate_user!, only: [ :home, :location, :vente, :reparation, :contact ]

  def home
    @categories = Category.order('name ASC')

    # Les plus recherchés
    @best_searches_choice = Product.where(best_searches_choice: true)
    @best_searches_auto = Product.order("nb_of_searches DESC").first(4)

    @best_searches = []

    if !@best_searches_choice.nil? && @best_searches_choice.size < 4
      @best_searches_choice.each do |product|
        @best_searches << product
      end
      Product.order("nb_of_searches DESC").first(4 - @best_searches_choice.size).each do |product|
        @best_searches << product
      end
    else
      @best_searches_auto.first(4).each do |product|
        @best_searches << product
      end
    end

    # Les nouveautés
    @new_product_choice = Product.where(new_product_choice: true)
    @new_product_auto = Product.order("created_at DESC").first(4)

    @new_products = []

    if !@new_product_choice.nil? && @new_product_choice.size < 4
      @new_product_choice.each do |product|
        @new_products << product
      end
      Product.order("created_at DESC").first(4 - @new_product_choice.size).each do |product|
        @new_products << product
      end
    else
      @new_product_auto.first(4).each do |product|
        @new_products << product
      end
    end

    # Used in new message form on home page
    @message = Message.new

    # Displaying promo
    @promo = Promo.where(display: true).last
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
    @users = User.all.where(admin: false)

    @lines = []

    # File.open("http://res.cloudinary.com/dto9foc0m/raw/upload/v1523893819/test.TXT", "r").each do |line|
    #   @lines << line
    # end

    # text = Net::HTTP.get( URI.parse( "http://res.cloudinary.com/dto9foc0m/raw/upload/v1523893819/test.TXT" ) )
    # text.split("\n").each do |line|
    #   @lines << line.split(" ")
    # end

    @messages = Message.order("created_at DESC").all
    @categories = Category.order('name ASC').all

    if params[:category].present?
      @current_category = Category.where(id: params[:category][:id]).take.name
      @products = Category.where(id: params[:category][:id]).take.products
    else
      @current_category = "TOUTES CATEGORIES"
      @products = Product.order("created_at DESC").all
    end

    @promos = Promo.all.order("created_at DESC").all
    # Category new
    @category = Category.new

    # Product new
    @product = Product.new

    # Promo new
    @promo = Promo.new

    # Fetching
    @products_most_searched = []
    @products_nb_searches = []
    @products_raking = Product.order("nb_of_searches DESC").all

    Product.order("nb_of_searches DESC").first(10).each do |product|
      @products_most_searched << product.name
      @products_nb_searches << product.nb_of_searches
    end

    @categories_hashes = []

    Category.all.each do |category|
      @categories_hashes << {
        name: category.name,
        nb_of_searches: Product.where(category_id: category.id)
                               .pluck(:nb_of_searches)
                               .reduce(:+)
      }
    end

    @categories_names = []
    @categories_nb_of_searches = []

    @categories_hashes.each do |category|
      @categories_names << category[:name]
      @categories_nb_of_searches << category[:nb_of_searches]
    end

    # if !@categories_hashes.nil?
    #   @categories_hashes.sort_by! { |element| element[:nb_of_searches] }
    # end
  end

  def synchronization
    require 'faker'
    require 'net/ftp'
    ftp = Net::FTP.new("ftp.cluster021.hosting.ovh.net")
  # run the script like
  # ruby ftp.rb username password
    ftp.login("loxambasii", "gaUhVmu4qXth")
    ftp.chdir("/gcom_tmp")

    files_ord = ftp.nlst('*.ord')
    files_pdf = ftp.nlst('*.pdf')

    puts "File list obtained... #{files_ord}"
    puts "File list obtained... #{files_pdf}"

    files_ord.each do |fname|
      puts "Downloading file #{fname}"
      ftp.getbinaryfile(fname, fname)

      text = File.open(fname).read
      text.each_line do |line|
        array = line.strip.split(/\;/)

        unless User.where(loxam_id: array[2]).exists?
          User.create(company: array[3], email: Faker::Internet.email,
                    password: Faker::IDNumber.valid, loxam_id: array[2])
        end

        files_pdf.each do |pdf_doc|
          if pdf_doc == array[6]
          p "#{pdf_doc} == #{array[6]}"
            ftp.getbinaryfile(pdf_doc, pdf_doc)
            new_doc = Document.new(document_type: "fac", user_id: User.where(loxam_id: array[2]).take.id)
            new_doc.remote_pdf_url = pdf_doc
            new_doc.save
          end
        end
      end
      File.delete(fname)
      File.delete(pdf_doc)
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
