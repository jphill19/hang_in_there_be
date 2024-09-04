require 'rails_helper'


describe "Posters API" do
  it "sends a list of Posters" do
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

    get '/api/v1/posters'

    expect(response).to be_successful

    posters_data = JSON.parse(response.body, symbolize_names: true)

    posters = posters_data[:data]

    expect(posters.count).to eq(3)

    posters.each do |poster|
      expect(poster).to have_key(:id)
      expect(poster[:id]).to be_an(Integer)

      expect(poster).to have_key(:name)
      expect(poster[:name]).to be_a(String)

      expect(poster).to have_key(:description)
      expect(poster[:description]).to be_a(String)

      expect(poster).to have_key(:price)
      expect(poster[:price]).to be_a(Float)

      expect(poster).to have_key(:year)
      expect(poster[:year]).to be_an(Integer)

      expect(poster).to have_key(:vintage)
      expect(poster[:vintage]).to be_in([ true, false ])

      expect(poster).to have_key(:img_url)
      expect(poster[:img_url]).to be_a(String)
    end
  end
end
