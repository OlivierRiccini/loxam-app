class PagesController < ApplicationController
  # before_action :all_products, only: [ :home, :mon_espace, :admin_dashboard, :vente, :location ]
  skip_before_action :authenticate_user!, only: [ :home, :location, :vente, :reparation,
                                                  :contact, :garantie_dommages, :documentations,
                                                  :conditions_generales_de_location ]

  include ActionView::Helpers::UrlHelper

  def home
    # @categories = Category.order('name ASC')

    @affiliates = Affiliate.all

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

    # contatc form home page
    @message = Message.new

    # Displaying promo and catalogs
    @promo = Promo.where(display: true).last
    @catalogs = Catalog.all

    # @new_favorite = Favorite.new

  end

  def mon_espace
    @user = current_user
    @invoices = Invoice.where(user_id: @user.id)

    # @products = []

    # @invoices.each do |invoice|
    #   invoice.transactions.each do |transaction|
    #     @products << Product.find(transaction.product_id)
    #   end
    # end

    # popular_products = @products.each_with_object(Hash.new(0)) do
    #   |m,h| h[m] += 1
    # end
    # @popular_products = popular_products.sort_by{ |k,v| v }.last(5).reverse
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
    # @products = Product.order("name DESC").all

    if params[:category].present?
      @current_category = Category.where(id: params[:category][:id]).take.name
      @products = Category.where(id: params[:category][:id]).take.products
    else
      @current_category = "TOUTES CATEGORIES"
      @products = Product.order("name ASC").all
    end

    @promos = Promo.all.order("created_at DESC").all
    # Category new
    @category = Category.new

    # Product new
    @product = Product.new
    @product.expendables.build

    # Promo new
    @promo = Promo.new

    # In promos section
    @catalogs = Catalog.all

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
                               .reduce(:+) || 0
      }

    @categories_hashes.sort_by! { |category| category[:nb_of_searches] }.reverse!
    end

    @categories_names = []
    @categories_nb_of_searches = []

    @categories_hashes.each do |category|
      @categories_names << category[:name]
      @categories_nb_of_searches << category[:nb_of_searches]
    end

    # Fetching
    Product.all.each do |product|
      product.update(present_in_favorites: product.favorites.count)
    end

    @products_most_saved = []
    @products_nb_times_currently_saved = []
    @favorites_ranking = Product.order('present_in_favorites DESC').all

    Product.order("present_in_favorites DESC").first(10).each do |product|
      @products_most_saved << product.name
      @products_nb_times_currently_saved << product.present_in_favorites
    end
  end

  def synchronization
    require 'faker'
    require 'net/ftp'
    ftp = Net::FTP.new("ftp.cluster005.ovh.net")
  # run the script like
  # ruby ftp.rb username password
    ftp.login("loxamcitjg-jyr", "D2HJfZdVbmebmEjM56Bn0JO7SIRsTu")
    ftp.chdir("/gcom_tmp")

    files_ord = ftp.nlst('*.ord')
    files_pdf = ftp.nlst('*.pdf')

    puts "File list obtained... #{files_ord}"
    puts "File list obtained... #{files_pdf}"

    files_ord.each do |fname|
      puts "Downloading file #{fname}"
      ftp.getbinaryfile(fname, fname)

      puts "///////////////////////"
      puts "I AM INSIDE ORDER FILE!"
      puts "///////////////////////"

      text = File.open(fname).read
      text.each_line do |line|
        file_order_columns = line.strip.encode('UTF-8', :invalid => :replace)
                                       .split(/\;/)

        puts "///////////////////////"
        puts "I AM CHECKING EACH LINE OF ORDER FILE!"
        puts "///////////////////////"

        unless User.where(loxam_id: file_order_columns[2]).exists? && file_order_columns[2] == "inexistant@lng.fr"
          puts "///////////////////////"
          puts "CREATING USER!"
          puts "///////////////////////"
          User.create(name: file_order_columns[3], email: file_order_columns[8],
                      password: "#{file_order_columns[2]}-#{file_order_columns[8]}",
                      loxam_id: file_order_columns[2])
        end

        date_to_dir_name = file_order_columns[7][0..5]
        dir_name = "public/assets/invoices/#{date_to_dir_name}"
        Dir.mkdir(dir_name) unless File.exists?(dir_name)

        files_pdf.each do |pdf_doc|
          # file_order_columns[6] == pdf id
          puts "///////////////////////"
          puts "CHECKING EACH PDF! #{pdf_doc} == #{file_order_columns[6]}"
          puts "///////////////////////"

          user = User.where(loxam_id: file_order_columns[2]).take
          if pdf_doc == file_order_columns[6] && !user.nil?

          puts "#{pdf_doc} == #{file_order_columns[6]}"
            # ftp.getbinaryfile(pdf_doc, pdf_doc)
            ftp.getbinaryfile(pdf_doc, "#{dir_name}/#{pdf_doc}")

            # unless user.invoices.any? { |invoice| invoice[:id_invoice_loxam] == file_order_columns[0] &&
            unless Invoice.where(id_invoice_loxam: file_order_columns[0]).exists?

              file_order_columns[1] == "FCLI" ? document_type = "Facture" : document_type = "Avoir"
              new_doc = Invoice.new(id_invoice_loxam: file_order_columns[0], document_type: document_type,
                                    date: file_order_columns[7], amount: file_order_columns[4],
                                    user_id: user.id, pdf: file_order_columns[6])
              # new_doc.remote_pdf_url = pdf_doc if File.size(pdf_doc) > 0
              new_doc.save
            end
            # File.delete(pdf_doc)
            # ftp.delete(pdf_doc)
          end
          # File.delete(pdf_doc)
          # ftp.delete(pdf_doc)
        end
      end
      File.delete(fname)
      # ftp.delete(fname)
    end
  end

  def location
    @rental_catalog = Catalog.where(catalog_type: "location").take
  end

  def vente
    @sales_catalog = Catalog.where(catalog_type: "vente").take
  end

  def contact
    @message = Message.new
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
    @rental_catalog = Catalog.where(catalog_type: "location").take
    @sales_catalog = Catalog.where(catalog_type: "vente").take
  end
end
