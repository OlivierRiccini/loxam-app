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

50.times do
  new_product = Product.create(name: Faker::Vehicle.manufacture,
                               reference: Faker::Vehicle.vin,
                               category: categories.sample,
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
