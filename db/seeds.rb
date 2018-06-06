# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = [].sort_by { |category| category[:index] }
products = [].sort_by { |category| category[:index] }
expendables = [].sort_by { |category| category[:index] }


require 'roo'

# xlsx = Roo::Spreadsheet.open(Rails.root.join('lib', 'seeds', 'products.xlsx'))
# xlsx = Roo::Excelx.new("./new_prices.xlsx")

# Use the extension option if the extension is ambiguous.
xlsx = Roo::Spreadsheet.open(Rails.root.join('lib', 'seeds', 'products.xlsx'), extension: :xlsx)

categories << {
  index: 1,
  name: xlsx.row(3)[1]
}

products << {
      index: 47,
      name: xlsx.row(47)[1],
      reference: xlsx.row(47)[0].to_s.split("-")[0],
      price: xlsx.row(47)[2],
      deposit: xlsx.row(47)[4]
    }

i = 0
xlsx.sheet('Liste tarifs').each do |row|
  i += 1

  if row[0].nil? && !row[1].nil?
    categories << {
      index: i,
      name: row[1]
    }
  end

  if row[3].class == Float && row[4].class == Float
    products << {
      index: i,
      name: row[1],
      reference: row[0].to_s.split("-")[0],
      price: row[2],
      deposit: row[4]
    }
  end

  if (row[4].class == String && !row[0].nil? && row[5].nil?)
    expendables << {
      index: i,
      name: row[1],
      reference: row[0],
      price: row[2],
      description: row[4]
    }
  end

end

categories.each do |category|
  Category.create(name: category[:name])
  puts "Category #{category[:name]} created!"
end

puts "Categories created!"

# products.each do |product|
#   new_product = Product.new( name: product[:name],
#                              reference: product[:reference],
#                              price: product[:price],
#                              features: Faker::Lorem.sentences(2),
#                              description: Faker::Lorem.paragraph,
#                              deposit: product[:deposit])
#   new_product.remote_photo_url = "http://res.cloudinary.com/dqgpcthzg/image/upload/v1526474527/loxam-machine.png"
#   new_product.save
# end
categories.each do |category|
  products.each do |product|
    new_product = Product.new( name: product[:name],
                               reference: product[:reference],
                               price: product[:price],
                               features: Faker::Lorem.sentences(2),
                               description: Faker::Lorem.paragraph,
                               deposit: product[:deposit])
    new_product.remote_photo_url = "http://res.cloudinary.com/dqgpcthzg/image/upload/v1526474527/loxam-machine.png"

    if categories.index(category) == categories.size - 1 && product[:index] > category[:index]
      new_product[:category_id] = Category.where(name: category[:name]).take.id
    elsif product[:index] > category[:index] &&
      product[:index] < categories[categories.index(category) + 1 ][:index]
      new_product[:category_id] = Category.where(na  me: category[:name]).take.id
    end
    new_product.save
  end
end
# categories.each do |category|
#   products.select do |product|
#     if categories.index(category) == categories.size - 1 && product[:index] > category[:index]
#       Product.where(name: product[:name]).update(category_id: Category.where(name: category[:name]).take.id)
#     elsif product[:index] > category[:index] &&
#        product[:index] < categories[categories.index(category) + 1 ][:index]
#       Product.where(name: product[:name]).update(category_id: Category.where(name: category[:name]).take.id)
#     end
#   end
# end

puts "Products created!"

promo = Promo.new(title: "Betonnière")
promo[:display] = true
promo.remote_media_url = "http://res.cloudinary.com/dqgpcthzg/image/upload/v1526483071/promo-loxam.jpg"
promo.save

puts "Promo!"

User.create(email: "info@olivierriccini.com", password: "Ronaldor99", admin: true)

puts "User created!"

puts "DB CREATED!"

# types = ['facture', 'facture', 'facture', 'facture', 'avoir']

# 10.times do
#   company = Faker::Company.name
#   new_user = User.create(company: company, email: "contact@#{company}.com", password: company)
#   new_user.remote_avatar_url = "https://picsum.photos/50/60/?random"
#   new_user.save
#   5.times do
#     new_document = Document.create(document_type: types.sample, user_id: new_user.id)
#     rand(1..30).times do
#       Transaction.create(product_id: rand(1..50), document_id: new_document.id)
#     end
#   end
#   puts "New company #{company} with 5 documents created!"
# end

# promo = Promo.new(title: "Betonnière")
# promo.remote_media_url = "http://res.cloudinary.com/dqgpcthzg/image/upload/v1526483071/promo-loxam.jpg"
# promo.save

# puts "Promo!"

# puts "DB CREATED!"
# require 'csv'

# csv_text = File.read('list.csv')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   puts row
# end

# require 'csv'

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'products-list.csv', :quote_char => "|"))
# # if ! csv_text.valid_encoding?
# #   s = csv_text.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
# #   s.gsub!("\"!", "")
# # end
# csv = CSV.parse(csv_text, :encoding => 'ISO-8859-1', :col_sep => ",")
# csv.each do |row|
#   puts row.to_h
# end
# require 'roo'

# xlsx = Roo::Spreadsheet.open(Rails.root.join('lib', 'seeds', 'products.xlsx'))
# xlsx = Roo::Excelx.new("./new_prices.xlsx")

# Use the extension option if the extension is ambiguous.
# xlsx = Roo::Spreadsheet.open(Rails.root.join('lib', 'seeds', 'products.xlsx'), extension: :xlsx)

# i = 0
# puts "47 - #{xlsx.row(47)[1]}"
# xlsx.sheet('Liste tarifs').each do |row|
#   products << {
#       index: 47,
#       name: row(47)[1],
#       reference: row(47)[0],
#       price: row(47)[2],
#       deposit: row(47)[4]
#     }
#   i += 1
#   if row[3].class == Float && row[4].class == Float
#     products << {
#       index: i,
#       name: row[1],
#       reference: row[0],
#       price: row[2],
#       deposit: row[4]
#     }
#   end
# end
