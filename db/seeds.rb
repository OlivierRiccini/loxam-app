# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = [ 'espaces verts', 'isolation - projection peinture & enduit', 'electrique & pneumatique',
               'ponçage décapage & sablage', 'nettoyage', 'sciage', 'divers', 'compactage', 'instrument de mesure',
               'perçage & fixation', 'élevation', 'pompes', 'plomberie génie climatique',
               'véhicule & transports', 'base de vie']

categories.each do |category|
  Category.create(name: category)
  puts "Category #{category} created!"
end

puts "Categories created!"

50.times do
  new_product = Product.create(name: Faker::Vehicle.manufacture,
                               category_id: rand(20..categories.size),
                               reference: Faker::Vehicle.vin,
                               price: rand(20..1000),
                               characteristics: Faker::Lorem.sentences(2),
                               description: Faker::Lorem.paragraph,
                               deposit: rand(20..10000),
                               technical_sheet: "http//#{Faker::Vehicle.manufacture}/technical_sheet",
                               video: "http//#{Faker::Vehicle.manufacture}/video",
                               loxam_link: "http//#{Faker::Vehicle.manufacture}/loxam.fr")
  new_product.remote_photo_url = "https://picsum.photos/200/300/?random"
  new_product.save
end


puts "Products created!"


types = ['facture', 'facture', 'facture', 'facture', 'avoir']

10.times do
  company = Faker::Company.name
  new_user = User.create(company: company, email: "contact@#{company}.com", password: company)
  new_user.remote_avatar_url = "https://picsum.photos/50/60/?random"
  new_user.save
  5.times do
    new_document = Document.create(document_type: types.sample, user_id: new_user.id)
    rand(1..30).times do
      Transaction.create(product_id: rand(1..50), document_id: new_document.id)
    end
  end
  puts "New company #{company} with 5 documents created!"
end

puts "DB CREATED!"


