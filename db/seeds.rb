# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Poster.destroy_all

Poster.create(name: "REGRET",
  description: "Hard work rarely pays off.",
  price: 89.00,
  year: 2018,
  vintage: true,
  img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

Poster.create(name: "Last Resort",
  description: "Cut my life into pieces, this is my last resort.",
  price: 109.00,
  year: 2000,
  vintage: true,
  img_url:  "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8")

Poster.create(name: "Potato",
  description: "You're a couch potato.",
  price: 3.00,
  year: 2014,
  vintage: true,
  img_url:  "https://as1.ftcdn.net/v2/jpg/05/60/56/58/1000_F_560565861_F81rpaECDU1hxBMkfL5N7WOMoUGra9hw.jpg")

Poster.create(name: "Work Hard, layoff hard",
  description: "You're a couch potato.",
  price: 43.0,
  year: 2022,
  vintage: false,
  img_url:  "https://cdn.statcdn.com/Infographic/images/normal/29175.jpeg")

Poster.create(name: "Aging",
  description: "The older you get, the more likely you are to forget why you walked into a room.",
  price: 43.0,
  year: 2022,
  vintage: true,
  img_url:  "https://media.istockphoto.com/id/91520053/photo/senior-man-shrugging-shoulders.jpg?s=612x612&w=0&k=20&c=x9iR8Az32VZwE0VOlu9s30Urp8HunhuwfBN2RmFCytg=")

  Poster.create(name: "Life",
  description: "Even if you eat well, exercise regularly, and do everything right, you're still going to age and eventually decline..",
  price: 144.00,
  year: 2021,
  vintage: false,
  img_url:  "https://media.npr.org/assets/img/2015/02/27/shapes-health_wide-9fd818f034b5e7e219510212b30fce18edab983a.jpg")

puts "Poster seeded succesfully"
