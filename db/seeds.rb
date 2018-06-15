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
      name_scraped = doc_product_page.search('#article h3').text.strip
      description_scraped = doc_product_page.search('#artcontain p').text.strip.split("CALCUL DU TEMPS DE LOCATION*")[0]
      # features_scraped = doc_product_page.search('#artcontain p').text.strip
      ref_scraped = doc_product_page.search('fieldset input/@value').text.strip
      products_scraped << { name: name_scraped,
                            image: image_scraped,
                            description: description_scraped,
                            reference: ref_scraped }
                            # features: features_scraped }
  end
end

# puts products_scraped[0][:reference]

ii = 0
Product.all.each do |product_from_db|
  # ii += 1 if product_from_db.name.include? product_from_scraping[:name]
  products_scraped.each do |product_from_scraping|
    unless product_from_scraping.nil?
      if product_from_scraping[:reference].include? product_from_db.reference ||
        product_from_db.reference.name.include? product_from_scraping[:name]
        then ii += 1
        puts "#{product_from_scraping[:name]}"
      end
      # if product_from_db.name.include? product_from_scraping[:name]
      #   ii += 1
      # end
    end
  end
end
# # //////////////////////////////////////////////
puts "ii = #{ii}"

# promo = Promo.new(title: "Betonnière", description: "Hola, bétonnière au top!")
# promo[:display] = true
# promo.remote_media_url = "http://res.cloudinary.com/dqgpcthzg/image/upload/v1526483071/promo-loxam.jpg"
# promo.save

# puts "Promo!"

# User.create(email: "info@olivierriccini.com", password: "Ronaldor99", admin: true)

# puts "User created!"

# puts "DB CREATED!"
