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

# products_scraped = []

# index_product = 0

# html_content_home_page = open("http://www.loxam-bastia.fr/").read
# doc_home_page = Nokogiri::HTML(html_content_home_page)
# doc_home_page.search('nav .lignesmenu .wrapper a/@href').each do |a_home_page|
#   url_category = "http://www.loxam-bastia.fr/#{a_home_page.text}"
#   name_category =  a_home_page.text.strip.upcase.gsub("MATERIEL/", "")
#                                                   .gsub(/\d/, "")
#                                                   .gsub("-", " ")
#                                                   .strip.downcase


#   new_category = Category.create(name: name_category)
#   puts "Category #{name_category} created!"

#   # parsing each category page
#   html_content_category_page = open(url_category).read

#   doc_category_page = Nokogiri::HTML(html_content_category_page)

#   doc_category_page.search('.pagination a/@href').each do |a_category_page|
#     url_each_category_page = "http://www.loxam-bastia.fr/#{a_category_page.text.strip.gsub('location.href=', '').gsub('\'', '')}"

#     html_each_category_page_content = open(url_each_category_page).read
#     doc_each_category_page = Nokogiri::HTML(html_each_category_page_content)

#       doc_each_category_page.search('.produits button/@onclick').each do |each_category_page|
#         url_product_page = "http://www.loxam-bastia.fr/#{each_category_page.text.strip.gsub('location.href=', '').gsub(/\'/, '')}"

#       # parsing each product page
#         html_content_product_page = open(url_product_page).read
#         doc_product_page = Nokogiri::HTML(html_content_product_page)
#         image_scraped = nil
#         doc_product_page.search('.wrapper img/@src').each do |img|
#           unless "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/cfpdt.png" ||
#             "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/cfpdt.png" ||
#             "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/logo-new-grey.png" ||
#             "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/isula-informatique-2016.png" ||
#             "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/logo-new.png" ||
#             "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/fb_grey.png" ||
#             "http://www.loxam-bastia.fr/#{img.text.strip}" == "http://www.loxam-bastia.fr/resources/images/inst_grey.png"

#             image_scraped = "http://www.loxam-bastia.fr/#{img.text.strip}"
#           end
#         end
#           name_scraped = doc_product_page.search('#arthead h3').text.strip
#           price_scraped = doc_product_page.search('#arthead span strong:first-child').text.strip.to_f
#           description_scraped = doc_product_page.search('#artcontain p').text.strip.split("CALCUL DU TEMPS DE LOCATION*")[0]
#           pdf_scraped = "http://www.loxam-bastia.fr/#{doc_product_page.search('#artcontain button/@onclick').text.strip
#                                                                                                                  .gsub('window.open', '')
#                                                                                                                  .gsub('_blank', '')
#                                                                                                                  .gsub(/[\'\)\(\,]/, '')
#                                                                                                                  .split('http')[0]}"



#         unless pdf_scraped == "http://www.loxam-bastia.fr/"
#           if pdf_scraped.split('/')[5] == "fiches"
#             technical_sheet_scraped = pdf_scraped
#             if pdf_scraped.include? "pdfresources"
#               technical_sheet_scraped = "#{pdf_scraped.split("resources")[0]}resources#{pdf_scraped.split("resources")[1]}"
#               features_scraped = "http://www.loxam-bastia.fr/resources#{pdf_scraped.split("resources")[2]}"
#             end
#           else
#             features_scraped = pdf_scraped
#           end
#         end

#         deposit_scraped = doc_product_page.search('#artcontain p').text.strip.split("Montant dépôt de garantie :")[1]
#                                                                              .split('€')[0]
#                                                                              .gsub(' ', '').to_f

#         ref_scraped = doc_product_page.search('fieldset input/@value').text.strip.split("-")[0]
#         new_product = Product.new( name: name_scraped,
#                                    price: price_scraped,
#                                    description: description_scraped,
#                                    reference: ref_scraped,
#                                    deposit: deposit_scraped,
#                                    category_id: new_category.id )

#         new_product.remote_photo_url = image_scraped

#         unless features_scraped.nil?
#           new_product.remote_features_url = features_scraped
#         end
#         new_product.remote_technical_sheet_url = technical_sheet_scraped
#         new_product.save
#         index_product += 1
#         puts "#{index_product} - #{new_product.name} created!"
#     end
#   end
# end

# puts "T'as presque fini!"

# promo = Promo.new(title: "Perseuse", description: "Hola, perseuse au top!")
# promo[:display] = true
# promo.remote_media_url = "https://res.cloudinary.com/dqgpcthzg/image/upload/v1531735927/catalogue-location.png"
# promo.save

# rental_catalog = Catalog.new(catalog_type: "location", link: "http://www.loxam.fr/location/catalogue/index.html")
# rental_catalog.remote_image_url = "https://res.cloudinary.com/dqgpcthzg/image/upload/v1531735927/catalogue-location.png"
# rental_catalog.save

# sales_catalog = Catalog.new(catalog_type: "vente", link: "http://www.loxam.fr/location/catalogue/index.html")
# sales_catalog.remote_image_url = "https://res.cloudinary.com/dqgpcthzg/image/upload/v1531744211/catalogue-vente.png"
# sales_catalog.save

# puts "Catalogs created!"
# puts "Promo!"

User.create(email: "loxam@loxam.fr", password: "loxambastia", name: "loxam bastia", admin: true)

# puts "User created!"

# i = 0
# images_from_vente_page_loxam = [
# "http://www.loxam.fr/files/vente/topographie.jpg",
# "http://www.loxam.fr/files/vente/equipement.jpg",
# "http://www.loxam.fr/files/vente/transport.jpg",
# "http://www.loxam.fr/files/vente/signalisation.jpg",
# "http://www.loxam.fr/files/vente/traitement-beton.jpg",
# "http://www.loxam.fr/files/vente/sciage.jpg",
# "http://www.loxam.fr/files/vente/perforation.jpg",
# "http://www.loxam.fr/files/vente/nettoyage.jpg",
# "http://www.loxam.fr/files/vente/elevation.jpg",
# "http://www.loxam.fr/files/vente/plomberie-climatisation.jpg",
# "http://www.loxam.fr/files/vente/traitement-sol.jpg",
# "http://www.loxam.fr/files/vente/outillage2.jpg",
# "http://www.loxam.fr/files/vente/consommables.jpg",
# "http://www.loxam.fr/files/vente/hygiene-epi.jpg",
# "http://www.loxam.fr/files/vente/espaces-verts.jpg",
# "http://www.loxam.fr/files/vente/maquettes2.jpg"
# ]

# images_from_vente_page_loxam.each do |image|
#   i += 1
#   Cloudinary::Uploader.upload(image, :public_id => "image-vente-page-#{i}")
#   puts image
# end

#############################################
#############################################

AffiliateImage.destroy_all
puts "Images deleted!"

AffiliateCategory.destroy_all
puts "Categories deleted!"

Affiliate.destroy_all
puts "Affiliates deleted!"

# LOXAM ACCESS
loxam_access = Affiliate.new(name: "loxam-access",
                             tagline: "L'élevation en toute confiance")
loxam_access.remote_logo_url = 'app/assets/images/access.png'
loxam_access.save

html_home_page = open("http://www.loxam-access.com/").read
find_categories = Nokogiri::HTML(html_home_page)

# Loxam access / Category
find_categories.search('#sidebar ul li').each do |category|

  # Category name
  category_name = category.search('a/@title').text

  # Category image and description
  category_link = category.search('a/@href').text
  unless category_link.include? "http://www.loxam-access.com/gamme"
    category_page = open("http://www.loxam-access.com#{category_link}").read
    find_elements = Nokogiri::HTML(category_page)
    page = find_elements.search('#content h1').text
    if page == "Loxam ACCESS, l’élévation grande hauteur avec opérateur"
      image_link = "http://www.loxam-access.com/img/img-loxam-lev.jpg"
      spec = "Nacelles sur porteur PL de – 12 à 84 m et de nacelles araignées de 16 à 50 m de hauteur de travail."
      description = "Nacelles sur porteur PL de 25 à 40 m, Nacelles sur porteur PL de 62 à 70 m,
                     Nacelles sur porteur PL de 41 à 61 m, Nacelles araignées"
    else
      image_link = "http://www.loxam-access.com/images/uploads/casque_chantier.gif"
      description = "Equipements antichute, Rubans - Grillages avertisseurs, Signaux de danger type AK,
                     Panneaux - Cônes - Séparateurs de voie, Triangle lumineux,
                     Vêtements haute visibilité, Casques, Gants, Chaussures de sécurité"
    end
  else
    category_page = open(category_link).read
    find_elements = Nokogiri::HTML(category_page)
    image = find_elements.search('#content .two-col div:first-child img/@src').text

    # Category image
    image_link = "http://www.loxam-access.com#{image}"

    spec_first = find_elements.search('.table-tabs li:first-child').text
    spec_last = find_elements.search('.table-tabs li:last-child').text
    splited_spec = "#{spec_first} #{spec_last}".split("à")
    spec = "Hauteurs de travail de #{splited_spec[0]} à #{splited_spec[2]}"

    # Category description
    description_ul = find_elements.search('.list1').text.strip
    description_text = find_elements.search('.two-col .last p:not(:last-child)').text.strip
    description = "#{description_ul}//#{description_text}"
  end

  new_category = AffiliateCategory.new(name: category_name, spec: spec,
                                       description: description,
                                       affiliate_id: loxam_access.id)
  new_category.remote_image_url = image_link
  new_category.save
end
# Images for LOXAM ACCESS
find_categories.search('.images li img/@src').each do |img|
  loxam_access_images = "http://www.loxam-access.com/#{img.text}"
  new_image = AffiliateImage.new(affiliate_id: loxam_access.id)
  new_image.remote_url_url = loxam_access_images
  new_image.save
end

puts "ACCES OK!"

#############################################
#############################################

# LOXAM MODULE
loxam_module = Affiliate.new(name: "loxam-module",
                             tagline: "Location et vente de constructions modulaires")
loxam_module.remote_logo_url = 'app/assets/images/module.png'
loxam_module.save

module_categories = [
                      {
                        name: "industrie",
                        spec: "Adapter l'espace de travail en toute sécurité",
                        description: "Pour étendre votre activité, aménager de
                                      nouveaux locaux ou accueillir les prestataires
                                      en période d'arrêt technique d'usine,
                                      LOXAM MODULE propose des constructions
                                      modulaires adaptées à vos besoins et aux
                                      contraintes de site industriel. Rapides à
                                      mettre en place et fonctionnelles, nos
                                      constructions modulaires vous offrent tout
                                      le confort indispensable dans le respect des
                                      normes techniques en vigueur (code du travail,
                                      réglementations hygiène-sécurité).
                                      Bureaux, laboratoire, local technique, poste de garde,
                                      réfectoire, vestiaires, sanitaires, espace de stockage...",
                        image: "http://www.loxam-module.com/img/slideshow/realisations_industrie1.jpg"
                      },
                      {
                        name: "commerces & services",
                        spec: "Offrir la proximité et la convivialité",
                        description: "Pour renforcer votre présence commerciale et
                                      accroître votre activité, LOXAM MODULE conçoit
                                      des espaces modulaires sur mesure répondant à
                                      l'ensemble des normes ERP en vigueur.
                                      Point d'accueil, bulle de vente, hall d'exposition,
                                      centre d'information, agence commerciale, magasin,
                                      restaurant, espace détente...",
                        image: "http://www.loxam-module.com/img/slideshow/tb_cs1.jpg"
                      },
                      {
                        name: "collectivités",
                        spec: "Recevoir tous les publics",
                        description: "En collaboration avec les Collectivités,
                                      LOXAM MODULE a développé des bâtiments et
                                      des infrastructures adaptés au milieu scolaire
                                      et associatif ainsi qu'aux services administratifs.
                                      Crèche, garderie, écoles, cantine scolaire
                                      locaux associatifs, club sportif, centre de loisirs
                                      office de tourisme, bureaux administratifs...",
                        image: "http://www.loxam-module.com/img/slideshow/realisations_collectivites5.jpg"
                      },
                      {
                        name: "événementiel",
                        spec: "Participer à la réussite de vos manifestations",
                        description: "Pour toutes vos manifestations culturelles,
                                      sportives et touristiques, LOXAM MODULE
                                      propose des espaces modulables et confortables
                                      pour recevoir tous les publics en garantissant
                                      le respect des normes ERP et les réglementations
                                      hygiène-sécurité en vigueur. Choisir LOXAM MODULE,
                                      c'est choisir des espaces modulaires au design
                                      étudié et personnalisé pour répondre à toutes vos
                                      thématiques évènementielles.
                                      Stand d'exposition, salle de conférence, espace de réception,
                                      point d'accueil, centre de presse, régie télévisuelle
                                      commissariat général, billetterie...",
                        image: "http://www.loxam-module.com/img/slideshow/realisations_events2.jpg"
                      },
                      {
                        name: "batiment - travaux publics",
                        spec: "Accompagner les bâtisseurs sur tous les chantiers",
                        description: "Besoin d'une base vie pour un nouveau chantier ?
                                      Pour quelques mois ou plusieurs années, LOXAM MODULE
                                      met en place rapidement des espaces modulaires
                                      fonctionnels offrant tout le confort indispensable
                                      dans le respect des normes techniques en vigueur
                                      (code du travail, réglementations hygiène-sécurité).
                                      Profitez de constructions modulaires 'clé en main'
                                      avec tous les aménagements et équipements adaptés
                                      à vos besoins (climatisation, câblages bureautique,
                                      mobilier...).
                                      Base vie, vestiaires, sanitaires, réfectoire, salle de réunion,
                                      espace de travail, cantonnement, bungalow de chantier
                                      espaces de stockage, locaux de gardiennage...",
                        image: "http://www.loxam-module.com/img/slideshow/realisations_btp2.jpg"
                      }
                    ]

module_categories.each do |category|
  new_category = AffiliateCategory.new(name: category[:name], spec: category[:spec],
                                       description: category[:description],
                                       affiliate_id: loxam_module.id)
  new_category.remote_image_url = category[:image]
  new_category.save
end

images_module = ["http://www.loxam-module.com/img/sct-industrie.jpg", "http://www.loxam-module.com/img/sct-commerce-services.jpg",
                 "http://www.loxam-module.com/img/sct-collectivites.jpg", "http://www.loxam-module.com/img/sct-evenementiel.jpg",
                 "http://www.loxam-module.com/img/sct-btp.jpg"]

# Images for LOXAM ACCESS
images_module.each do |image|
  new_image = AffiliateImage.new(affiliate_id: loxam_module.id)
  new_image.remote_url_url = image
  new_image.save
end

puts "MODULE OK!"

##################################################
###################################################

# LOXAM TP
loxam_tp = Affiliate.new(name: "loxam-tp",
                         tagline: "Loxam TP est le spécialiste de la location
                                   de matériels lourds pour le terrassement,
                                   le compactage et la démolition.")
loxam_tp.remote_logo_url = 'app/assets/images/tp.png'
loxam_tp.save

tp_categories = [
                  {
                    name: "pelles",
                    spec: "Pelles sur chenilles de ou sur pneus de 13 à 35T.",
                    description: "La pelle dur chenilles est très appréciée
                                  pour sa polyvalence sur chantier, elle permet
                                  en fonction de l’accessoire utilisé de creuser
                                  des fondations, remblayer, lever des charges,
                                  démolir, trier, raboter...celle sur pneus est
                                  indispensables sur un chantier urbain, elles
                                  permettent de réaliser des travaux de terrassement,
                                  d’espaces verts, de démolition, de VRD.
                                  Leur configuration les rend très mobiles sur
                                  terrain plat, stabilisé et sur route.",
                    image: "http://loxam-tp.com/IMG/arton6.gif"
                  },
                  {
                    name: "chargeuses",
                    spec: "chargeuses sur pneus de 1500 à 300L.",
                    description: "La chargeuse permet la manutention de matériaux en vrac.
                                  Elle peut aussi servir au déblayage après terrassement
                                  et au remblayage des tranchées.",
                    image: "http://loxam-tp.com/IMG/arton34.gif"
                  },
                  {
                    name: "tombereau",
                    spec: "Tombereau articulé 10 T",
                    description: "En collaboration avec les Collectivités,
                                  Spécialement conçu pour affronter les dénivelés
                                  et les irrégularités de passage, le tombereau
                                  articulé est le moyen le plus efficace pour
                                  transporter vos chargements de terre ou de
                                  matériaux à travers vos chantiers les plus
                                  difficiles d’accès. Charge utile maxiamle
                                  de 10t et motricité 4 RMmm.",
                    image: "http://loxam-tp.com/IMG/arton35.gif"
                  },
                  {
                    name: "compacteurs",
                    spec: "Du rouleau tandem au compacteur monobille en passant par
                           le compacteur à pneus. De 7 à 24 T.",
                    description: "Le rouleau tandem est parfait pour les
                                  chantiers de grande envergure (routiers,
                                  autoroutiers, aéroportaires). Compactage
                                  des couches de base et d’asphalte.
                                  Le compacteur à pneus est principalement destiné
                                  aux travaux de finition de surface des enrobés
                                  et des sols. Il est particulièrement efficace
                                  sur les revêtements minces qui ne supportent
                                  pas les vibrations. L’action des pneumatiques
                                  permet de réaliser un excellent scellement de
                                  surface des enrobés bitumeux grâce à l’effet
                                  de malaxage des pneus et améliore considérablement
                                  la rugosité du revêtement.
                                  Et enfin, le compacteur monobille est destiné
                                  aux travaux de construction routière et autoroutière
                                  et permet la réalisation de plateformes comme des
                                  parkings, des aéroports, des aménagements portuaires.",
                    image: "http://loxam-tp.com/IMG/arton11.jpg"
                  },
                  {
                    name: "brumisateurs",
                    spec: "Brumisateur de chantier, rayon d’action de 40 / 50m et
                           consommation d’eau de 43l.",
                    description: "Le brumisateur de chantier permet d’améliorer
                                  grandement les conditions de travail dans
                                  les environnements poussiéreux en projetant
                                  des micros gouttelettes qui capturent les
                                  poussières pour les faire descendre au sol
                                  par gravité.",
                    image: "http://loxam-tp.com/IMG/arton10.gif"
                  },
                  {
                    name: "robots de démolition",
                    spec: "",
                    description: "Le robot de démolition est adapté aux travaux
                                  de démolition et de réhabilitation dans des
                                  environnements difficiles. Doté de toute la
                                  gamme d’accessoires de démolition, il répond
                                  à tous les exigences en matière de démolition
                                  et de déconstruction. Le robot de démolition
                                  assure confort et sécurité au travail :
                                  l’opérateur ne subit aucune vibration et
                                  n’est pas exposé en zone de risques.",
                    image: "http://loxam-tp.com/IMG/arton65.gif"
                  },
                  {
                    name: "accessoires",
                    spec: "",
                    description: "Benne preneuse, BRH, Broyeur à béton,
                                  Cisaille à béton, Dent de dérochage,
                                  Godet de curage, Godet rétro, Pince de tri,
                                  Cisaille à ferraille, Godet à griffes...",
                    image: "http://loxam-tp.com/IMG/arton42.gif"
                  }
                ]

tp_categories.each do |category|
  new_category = AffiliateCategory.new(name: category[:name], spec: category[:spec],
                                       description: category[:description],
                                       affiliate_id: loxam_tp.id)
  new_category.remote_image_url = category[:image]
  new_category.save
end

images_tp = ["http://loxam-tp.com/IMG/arton66.gif", "http://loxam-tp.com/IMG/arton72.gif",
             "http://loxam-tp.com/IMG/arton72.gif", "http://loxam-tp.com/IMG/arton75.gif",
             "http://loxam-tp.com/IMG/arton76.jpg"]

# Images for LOXAM ACCESS
images_tp.each do |image|
  new_image = AffiliateImage.new(affiliate_id: loxam_tp.id)
  new_image.remote_url_url = image
  new_image.save
end

puts "TP OK!"

############################################
############################################


# LOXAM POWER
loxam_power = Affiliate.new(name: "loxam-power",
                            tagline: "Location de matériel industriel.")
loxam_power.remote_logo_url = 'app/assets/images/power.png'
loxam_power.save

power_categories = [
                  {
                    name: "air comprimé",
                    spec: "Location de compresseurs.",
                    description: "Qu’il s’agisse de pannes ou de pics de production
                                  nécessitant un apport d’air supplémentaire, d’une
                                  phase de maintenance ou de réparation de vos
                                  installations, LOXAM POWER met à votre disposition
                                  une large gamme de compresseurs jusqu'à 2700 m3/h
                                  (thermiques ou électriques, lubrifiés ou air sans
                                  huile, haute ou basse pression), ainsi que tous
                                  les accessoires et services associés.",
                    image: "http://loxam-power.fr/img/categories/Compresseurs-thermiques-air-lubrifie.jpg"
                  },
                  {
                    name: "traitement d'air",
                    spec: "Location de matériel de traitement d’air.",
                    description: "Notre gamme de traitement d’air permet de répondre
                                  aux critères requis : température, point de
                                  rosée, air sans huile, air respirable…
                                  Afin d’être en adéquation avec vos besoins,
                                  LOXAM POWER met à votre disposition une large
                                  gamme d’équipement (sécheurs, unités de
                                  dessiccation, aéroréfrigérants, unités d’air
                                  respirable…), permettant de garantir la continuité
                                  de votre production dans les meilleurs conditions.",
                    image: "http://loxam-power.fr/img/categories/Unite-de-sechage.jpg"
                  },
                  {
                    name: "electricité",
                    spec: "Location de groupes électrogènes",
                    description: "Qu’il s’agisse d’une rupture du réseau électrique,
                                  ou d’un besoin planifié (complément de puissance,
                                  alimentation d’une installation temporaire…),
                                  LOXAM POWER met à votre disposition sa large
                                  gamme de groupes électrogènes jusqu’à 2 000 kVA
                                  ainsi que tous les accessoires et services associés.",
                    image: "http://loxam-power.fr/img/categories/Groupes-electrogenes-insonorises-de-12-a-500-kVA.jpg"
                  },
                  {
                    name: "contrôle de température",
                    spec: "Location de matériel de contrôle de température",
                    description: "Afin de répondre à vos exigences très précises
                                  en matière d’énergie frigorifique et climatique
                                  et de faire face à toutes les situations,
                                  LOXAM POWER vous propose ses gammes dédiées de
                                  groupes de production d’eau glacée jusqu’à 650
                                  kW et de climatiseurs jusqu’à 85 kW.",
                    image: "http://loxam-power.fr/img/categories/Groupes-de-production-d-eau-glacee.jpg"
                  },
                  {
                    name: "soudage",
                    spec: "Location de matériel de soudage",
                    description: "Pour tous vos travaux de chaudronnerie (soudage, découpage),
                                  LOXAM POWER vous propose en location, une large
                                  gamme de groupes de soudage autonomes ou électriques
                                  permettant de nombreux types de procédés :
                                  ARC, TIG, et ARC-AIR.",
                    image: "http://loxam-power.fr/img/categories/Postes-electriques.jpg"
                  },
                  {
                    name: "pompage",
                    spec: "Location de pompes industrielles",
                    description: "En cas de sinistre ou lors de phases de maintenance,
                                  de travaux ou de réparation, il est nécessaire
                                  de maîtriser et gérer les niveaux d’eau. Ainsi,
                                  LOXAM POWER met à votre disposition une large
                                  gamme de pompes pour des eaux claires à très
                                  chargées, jusqu’à 1 200 m³/h, pompes de surface
                                  ou immergées, pompes haute pression, pompes diesel,
                                  pneumatiques ou électriques.",
                    image: "http://loxam-power.fr/img/categories/Pompes-electriques.jpg"
                  }
                ]

power_categories.each do |category|
  new_category = AffiliateCategory.new(name: category[:name], spec: category[:spec],
                                       description: category[:description],
                                       affiliate_id: loxam_power.id)
  new_category.remote_image_url = category[:image]
  new_category.save
end

images_power = ["http://loxam-power.fr/img/homeBkg/img0.jpg", "http://loxam-power.fr/img/homeBkg/img1.jpg",
             "http://loxam-power.fr/img/homeBkg/img2.jpg", "http://loxam-power.fr/img/homeBkg/img3.jpg",
             "http://loxam-power.fr/img/homeBkg/img4.jpg"]

# Images for LOXAM POWER
images_power.each do |image|
  new_image = AffiliateImage.new(affiliate_id: loxam_power.id)
  new_image.remote_url_url = image
  new_image.save
end

puts "POWER OK!"


puts "DB CREATED!"







