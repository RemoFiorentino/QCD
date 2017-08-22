# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
I18n.reload!
# 30.times do
#     Answergroup.create!([{
#         qcd_id: 3,
#         group: true,
#         answer: {
#             "1"=>"#{Faker::RickAndMorty.quote}", 
#             "2"=>"#{Faker::Number.between(1, 5)}", 
#             "3"=>"#{Faker::Number.between(0, 3)}", 
#             "13"=>"#{Faker::Name.Promedioqcd}", 
#             "14"=>"#{Faker::Name.SiONo}", 
#             "15"=>"#{Faker::Number.between(1, 4)}", 
#             "16"=>"#{Faker::Number.between(1, 4)}", 
#             "17"=>"#{Faker::Number.between(1, 4)}",  
#             "18"=>"#{Faker::Number.between(1, 4)}",  
#             "19"=>"#{Faker::Number.between(1, 4)}",  
#             "20"=>"#{Faker::Number.between(1, 4)}",  
#             "21"=>"#{Faker::Number.between(1, 4)}",  
#             "22"=>"#{Faker::Number.between(1, 4)}",  
#             "23"=>"#{Faker::Number.between(1, 4)}",  
#             "24"=>"#{Faker::Number.between(1, 4)}"
#         }.to_json
#     }])
# end

# 30.times do
#     Answergroup.create!([{
#         qcd_id: 3,
#         group: false,
#         answer: {
#             "31"=>"#{Faker::RickAndMorty.quote}", 
#             "32"=>"#{Faker::RickAndMorty.quote}",  
#             "33"=>"#{Faker::Number.between(1, 9)}", 
#             "34"=>"#{Faker::Number.between(1, 9)}", 
#             "35"=>"#{Faker::RickAndMorty.quote}", 
#         }.to_json
#     }])
# end
User.create!([{
    name: "Mario Alberto Gomez Villadiego",
    admin: true,
    created_at: "2017-01-12 21:53:03",
    updated_at: "2017-05-20 00:48:01",
    email: "villadiegom@uninorte.edu.co",
    provider: "google_oauth2",
    uid: "110505826863566833300",
    ubicacion: "Laboratorio de Aprendizaje Docente - LAD",
    password: "123456"
}])

User.create!([{
    name: "Remo Jose Fiorentino Casadiego",
    admin: true,
    created_at: "2017-01-12 21:53:03",
    updated_at: "2017-05-20 00:48:01",
    email: "remojose29@gmail.com",
    provider: "google_oauth2",
    uid: "118268689822501171019",
    ubicacion: "Laboratorio de Aprendizaje Docente - LAD",
    password: "123456"
}])

