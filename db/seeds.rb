# categories = [].sort_by { |category| category[:index] }
# products = [].sort_by { |product| product[:index] }
# expendables = [ {
#       index: 90,
#       name: "FORFAIT D'USURE PONCEUSE SURFACEUSE DE SOLS (GLTREX)",
#       reference: "USURESEGLTREX",
#       price: 185.0,
#       description: "1 FORFAIT = 2 JOURS DE LOCATION"
#     }]

# require 'roo'

# # xlsx = Roo::Spreadsheet.open(Rails.root.join('lib', 'seeds', 'products.xlsx'))
# # xlsx = Roo::Excelx.new("./new_prices.xlsx")

# # Use the extension option if the extension is ambiguous.
# xlsx = Roo::Spreadsheet.open(Rails.root.join('lib', 'seeds', 'products.xlsx'), extension: :xlsx)

# categories << {
#   index: 1,
#   name: xlsx.row(3)[1]
# }

# products << {
#       index: 47,
#       name: xlsx.row(47)[1],
#       reference: xlsx.row(47)[0].to_s.split("-")[0],
#       price: xlsx.row(47)[2],
#       deposit: xlsx.row(47)[4]
#     }

# i = 0
# xlsx.sheet('Liste tarifs').each do |row|
#   i += 1

#   if row[0].nil? && !row[1].nil?
#     categories << {
#       index: i,
#       name: row[1]
#     }
#   end

#   if row[3].class == Float && row[4].class == Float
#     products << {
#       index: i,
#       name: row[1],
#       reference: row[0].to_s.split("-")[0],
#       price: row[2],
#       deposit: row[4]
#     }
#   end

#   if (row[4].class == String && !row[0].nil? && row[5].nil?)
#     expendables << {
#       index: i,
#       name: row[1],
#       reference: row[0],
#       price: row[2],
#       description: row[4]
#     }
#   end

# end

# # sorting expandable now because I had to add manually an item at the begining
# expendables.sort_by! { |expendable| expendable[:index] }

# categories.each do |category|
#   Category.create(name: category[:name])
#   # puts "Category #{category[:name]} created!"
# end

# puts "Categories created!"

# categories.each do |category|
#   products.each do |product|
#     new_product = Product.new( name: product[:name],
#                                reference: product[:reference],
#                                price: product[:price],
#                                features: Faker::Lorem.sentences(2),
#                                description: Faker::Lorem.paragraph,
#                                deposit: product[:deposit])
#     new_product.remote_photo_url = "http://res.cloudinary.com/dqgpcthzg/image/upload/v1526474527/loxam-machine.png"

#     if categories.index(category) == categories.size - 1 && product[:index] > category[:index]
#       new_product[:category_id] = Category.where(name: category[:name]).take.id
#     elsif product[:index] > category[:index] &&
#       product[:index] < categories[categories.index(category) + 1 ][:index]
#       new_product[:category_id] = Category.where(name: category[:name]).take.id
#     end
#     new_product.save
#     # puts "#{new_product.name} created!"

#     expendables.size
#     expendables.each do |expendable|
#       if product[:index] + 1 == expendable[:index]
#         Expendable.create( name: expendable[:name],
#                            reference: expendable[:reference],
#                            price: expendable[:price],
#                            description: expendable[:description],
#                            product_id: new_product.id )
#         # puts "#{expendable[:name]} created!"
#       end
#     end
#   end
# end

# puts "Products created!"
# puts "Expendables created!"

# /////////////////////////////////////////////////////////////


#scraping
require 'open-uri'
require 'nokogiri'

products_scraped = []

html_content_home_page = open("http://www.loxam-bastia.fr/").read
doc_home_page = Nokogiri::HTML(html_content_home_page)
doc_home_page.search('nav .lignesmenu .wrapper a/@href').each do |a_home_page|
  url_category = "http://www.loxam-bastia.fr/#{a_home_page.text.strip}"
  name_category =  a_home_page.text.strip.upcase.gsub("MATERIEL/", "")
                                                .gsub(/\d/, "")
                                                .gsub("-", " ")
  new_category = Category.create(name: name_category)
  puts "Category #{name_category} created!"
  # parsing each category page
  html_content_category_page = open(url_category).read
  doc_category_page = Nokogiri::HTML(html_content_category_page)
  doc_category_page.search('.produits .pdtslayer/@onclick').each do |a_category_page|


    url_product = "http://www.loxam-bastia.fr/#{a_category_page.text.strip.gsub('location.href=', '').gsub('\'', '')}"
    # parsing each product page
    html_content_product_page = open(url_product).read
    doc_product_page = Nokogiri::HTML(html_content_product_page)
    image_scraped = nil
    doc_product_page.search('.wrapper img/@src').each do |img|
      unless "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/cfpdt.png" ||
        "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/cfpdt.png" ||
        "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/logo-new-grey.png" ||
        "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/isula-informatique-2016.png" ||
        "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/logo-new.png" ||
        "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/fb_grey.png" ||
        "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/inst_grey.png"

        image_scraped = "http://www.loxam-bastia.fr/#{img.text.strip}"
      end
    end
      name_scraped = doc_product_page.search('#arthead h3').text.strip
      price_scraped = doc_product_page.search('#arthead span strong:first-child').text.strip.to_f
      description_scraped = doc_product_page.search('#artcontain p').text.strip.split("CALCUL DU TEMPS DE LOCATION*")[0]
      pdf_scraped = "http://www.loxam-bastia.fr/#{doc_product_page.search('#artcontain button/@onclick').text.strip
                                                                                  .gsub('window.open', '')
                                                                                  .gsub('_blank', '')
                                                                                  .gsub(/[\'\)\(\,]/, '')}"
      # technical_sheet_scraped = nil
      # features_scraped = nil
      unless pdf_scraped == "http://www.loxam-bastia.fr/"
        if pdf_scraped.split('/')[5] == "fiches"
          technical_sheet_scraped = pdf_scraped.split('/')[5]
          p pdf_scraped
        else
          features_scraped = pdf_scraped.split('/')[5]
        end
      end
      # puts features_scraped
      # expendables_scraped = doc_product_page.search('#artcontain p').text.strip.split("CALCUL DU TEMPS DE LOCATION*")[0]
                                                                               # .split("ACCESSOIRES / CONSOMMABLES")[1]
      # expendables_price_scraped = doc_product_page.search('#artcontain p').text.strip.split("CALCUL DU TEMPS DE LOCATION*")[0]
                                                                               # .split("ACCESSOIRES / CONSOMMABLES")[1]

      # unless expendables_price_scraped.nil? || expendables_price_scraped == ""
      #   expendables_price_scraped = expendables_price_scraped.split(" €")[0].split(":")[1].to_f
      # end
      # puts expendables_scraped if expendables_scraped

      deposit_scraped = doc_product_page.search('#artcontain p').text.strip.split("Montant dépôt de garantie :")[1]
                                                                           .gsub(/\D/, "").to_f

      ref_scraped = doc_product_page.search('fieldset input/@value').text.strip
      new_product = Product.new( name: name_scraped,
                                 price: price_scraped,
                                 description: description_scraped,
                                 reference: ref_scraped,
                                 deposit: deposit_scraped,
                                 category_id: new_category.id )

      new_product.remote_photo_url = image_scraped
      new_product.remote_features_url = features_scraped
      new_product.remote_technical_sheet_url = technical_sheet_scraped
      new_product.save
      puts "#{new_product.name} created!"
  end
end

puts "T'as presque fini!"

# ii = 0
# Product.all.each do |product_from_db|
#   products_scraped.each do |product_from_scraping|
#     unless product_from_scraping.nil?
#       if (product_from_scraping[:name].include? product_from_db.name) ||
#         (product_from_scraping[:reference].include? product_from_db.reference)
#         puts "#{product_from_scraping[:name]} - #{product_from_scraping[:reference]} ===== #{product_from_db.name} - #{product_from_db.reference}"
#         ii += 1
#       end
#     end
#   end
# end
# products_scraped.each do |product|
#   puts "#{product[:reference]} - #{product[:name]} - #{product[:description]}"
#   ii += 1
# end
# # //////////////////////////////////////////////
# puts "ii = #{ii}"

promo = Promo.new(title: "Betonnière", description: "Hola, bétonnière au top!")
promo[:display] = true
promo.remote_media_url = "http://res.cloudinary.com/dqgpcthzg/image/upload/v1526483071/promo-loxam.jpg"
promo.save

puts "Promo!"

User.create(email: "info@olivierriccini.com", password: "Ronaldor99", company: "loxam bastia", admin: true)

puts "User created!"

puts "DB CREATED!"
