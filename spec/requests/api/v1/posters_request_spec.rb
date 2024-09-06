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
      expect(poster[:id]).to be_an(String)

      expect(poster).to have_key(:type)
      expect(poster[:type]).to be_a(String)

      expect(poster).to have_key(:attributes)
      attributes = poster[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to be_a(String)

      expect(attributes).to have_key(:price)
      expect(attributes[:price]).to be_a(Float)

      expect(attributes).to have_key(:year)
      expect(attributes[:year]).to be_an(Integer)

      expect(attributes).to have_key(:vintage)
      expect(attributes[:vintage]).to be_in([ true, false ])

      expect(attributes).to have_key(:img_url)
      expect(attributes[:img_url]).to be_a(String)
    end
  end

  it "sends a list of ascending posters when there are query params for ascending" do
    poster0 = Poster.create(name: "REGRET",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

    poster1 = Poster.create(name: "Last Resort",
    description: "Cut my life into pieces, this is my last resort.",
      price: 109.00,
      year: 2000,
      vintage: true,
      img_url:  "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8")

    poster2 = Poster.create(name: "Potato",
      description: "You're a couch potato.",
      price: 3.00,
      year: 2014,
      vintage: true,
      img_url:  "https://as1.ftcdn.net/v2/jpg/05/60/56/58/1000_F_560565861_F81rpaECDU1hxBMkfL5N7WOMoUGra9hw.jpg")

    get '/api/v1/posters?sort=asc'

    expect(response).to be_successful

    posters_data = JSON.parse(response.body, symbolize_names: true)

    posters = posters_data[:data]
    # require 'pry'; binding.pry
    expect(posters[0][:attributes][:name]).to eq(poster0[:name])
    expect(posters[0][:attributes][:description]).to eq(poster0[:description])
    expect(posters[0][:attributes][:year]).to eq(poster0[:year])
    expect(posters[0][:attributes][:vintage]).to eq(poster0[:vintage])
    expect(posters[0][:attributes][:img_url]).to eq(poster0[:img_url])

    expect(posters[2][:attributes][:name]).to eq(poster2[:name])
    expect(posters[2][:attributes][:description]).to eq(poster2[:description])
    expect(posters[2][:attributes][:year]).to eq(poster2[:year])
    expect(posters[2][:attributes][:vintage]).to eq(poster2[:vintage])
    expect(posters[2][:attributes][:img_url]).to eq(poster2[:img_url])
  end

  it "sends a list of descending posters when there are query params for descending" do
    poster0 = Poster.create(name: "REGRET",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

    poster1 = Poster.create(name: "Last Resort",
    description: "Cut my life into pieces, this is my last resort.",
      price: 109.00,
      year: 2000,
      vintage: true,
      img_url:  "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8")

    poster2 = Poster.create(name: "Potato",
      description: "You're a couch potato.",
      price: 3.00,
      year: 2014,
      vintage: true,
      img_url:  "https://as1.ftcdn.net/v2/jpg/05/60/56/58/1000_F_560565861_F81rpaECDU1hxBMkfL5N7WOMoUGra9hw.jpg")

    get '/api/v1/posters?sort=desc'

    expect(response).to be_successful

    posters_data = JSON.parse(response.body, symbolize_names: true)

    posters = posters_data[:data]
    # require 'pry'; binding.pry
    expect(posters[0][:attributes][:name]).to eq(poster2[:name])
    expect(posters[0][:attributes][:description]).to eq(poster2[:description])
    expect(posters[0][:attributes][:year]).to eq(poster2[:year])
    expect(posters[0][:attributes][:vintage]).to eq(poster2[:vintage])
    expect(posters[0][:attributes][:img_url]).to eq(poster2[:img_url])

    expect(posters[2][:attributes][:name]).to eq(poster0[:name])
    expect(posters[2][:attributes][:description]).to eq(poster0[:description])
    expect(posters[2][:attributes][:year]).to eq(poster0[:year])
    expect(posters[2][:attributes][:vintage]).to eq(poster0[:vintage])
    expect(posters[2][:attributes][:img_url]).to eq(poster0[:img_url])
  end  

  it "can get one poster by its id" do
    id = Poster.create(name: "Last Resort",
    description: "Cut my life into pieces, this is my last resort.",
    price: 109.00,
    year: 2000,
    vintage: true,
    img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8").id

    get "/api/v1/posters/#{id}"

    posters_data = JSON.parse(response.body, symbolize_names: true)

    poster = posters_data[:data]

    expect(response).to be_successful
    expect(poster).to have_key(:id)
    expect(poster[:id]).to be_an(String)

    expect(poster).to have_key(:type)
    expect(poster[:type]).to be_a(String)

    expect(poster).to have_key(:attributes)
    attributes = poster[:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to be_a(String)

    expect(attributes).to have_key(:price)
    expect(attributes[:price]).to be_a(Float)

    expect(attributes).to have_key(:year)
    expect(attributes[:year]).to be_an(Integer)

    expect(attributes).to have_key(:vintage)
    expect(attributes[:vintage]).to eq(true)

    expect(attributes).to have_key(:img_url)
    expect(attributes[:img_url]).to be_a(String)
  end

  it "can delete a poster" do
    poster =  Poster.create(name: "Last Resort",
      description: "Cut my life into pieces, this is my last resort.",
      price: 109.00,
      year: 2000,
      vintage: true,
      img_url:  "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8")


    expect(Poster.count).to eq(1)

    delete "/api/v1/posters/#{poster.id}"

    expect(response).to be_successful
    expect(Poster.count).to eq(0)
    expect{ Poster.find(poster.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can update an existing song" do
    id = Poster.create(name: "Last Resort",
    description: "Cut my life into pieces, this is my last resort.",
    price: 109.00,
    year: 2000,
    vintage: true,
    img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8").id
    previous_description = Poster.last.description
    poster_params = { description: "There is hope after all" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/posters/#{id}", headers: headers, params: JSON.generate({poster: poster_params})
    poster = Poster.find_by(id: id)

    expect(response).to be_successful
    expect(poster.description).to_not eq(previous_description)
    expect(poster.description).to eq("There is hope after all")

    expect(response).to be_successful
    posters_data = JSON.parse(response.body, symbolize_names: true)
    poster = posters_data[:data]

    expect(response).to be_successful
    expect(poster).to have_key(:id)
    expect(poster[:id]).to be_an(String)

    expect(poster).to have_key(:type)
    expect(poster[:type]).to be_a(String)

    expect(poster).to have_key(:attributes)
    attributes = poster[:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to be_a(String)

    expect(attributes).to have_key(:price)
    expect(attributes[:price]).to be_a(Float)

    expect(attributes).to have_key(:year)
    expect(attributes[:year]).to be_an(Integer)

    expect(attributes).to have_key(:vintage)
    expect(attributes[:vintage]).to eq(true)

    expect(attributes).to have_key(:img_url)
    expect(attributes[:img_url]).to be_a(String)
  end

  it "can create a new poster" do
    poster_params = {
      name: "People will dislike you",
      description: "No matter how hard you try, you will never be able to please everyone",
      price: 153.00,
      year: 1995,
      vintage: true,
      img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8"
    }
  
    headers = { "CONTENT_TYPE" => "application/json" }
  
    post "/api/v1/posters", headers: headers, params: JSON.generate(poster_params)
  
    created_poster = Poster.last

    expect(created_poster.name).to eq(poster_params[:name])
    expect(created_poster.description).to eq(poster_params[:description])
    expect(created_poster.price).to eq(poster_params[:price])
    expect(created_poster.year).to eq(poster_params[:year])
    expect(created_poster.vintage).to eq(poster_params[:vintage])
    expect(created_poster.img_url).to eq(poster_params[:img_url])
    
    expect(response).to be_successful
    posters_data = JSON.parse(response.body, symbolize_names: true)
    poster = posters_data[:data]

    expect(response).to be_successful
    expect(poster).to have_key(:id)
    expect(poster[:id]).to be_an(String)

    expect(poster).to have_key(:type)
    expect(poster[:type]).to be_a(String)

    expect(poster).to have_key(:attributes)
    attributes = poster[:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to be_a(String)

    expect(attributes).to have_key(:price)
    expect(attributes[:price]).to be_a(Float)

    expect(attributes).to have_key(:year)
    expect(attributes[:year]).to be_an(Integer)

    expect(attributes).to have_key(:vintage)
    expect(attributes[:vintage]).to eq(true)

    expect(attributes).to have_key(:img_url)
    expect(attributes[:img_url]).to be_a(String)
  end

  it "returns a count of the posters shown with only one poster" do
    # Create a single poster for the test
    Poster.create(
      name: "REGRET",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

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

  
    get '/api/v1/posters'
  
    json_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(json_response).to have_key(:meta)
    expect(json_response[:meta]).to have_key(:count)
    expect(json_response[:meta][:count]).to eq(3)
  end 

  it "returns posters filtered by name" do
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
  
    get '/api/v1/posters', params: {name:'last'}
  
    json_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(json_response).to have_key(:meta)
    expect(json_response[:meta][:count]).to eq(1)
  
    posters = json_response[:data].first
    # binding.pry
    expect(posters[:attributes][:name]).to eq("Last Resort")
    expect(posters[:attributes][:description]).to eq("Cut my life into pieces, this is my last resort.")
    expect(posters[:attributes][:price]).to eq(109.0)
    expect(posters[:attributes][:year]).to eq(2000)
    expect(posters[:attributes][:vintage]).to eq(true)
    expect(posters[:attributes][:img_url]).to eq("https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8")
  end

  it "returns posters filtered by name and sorted alphabetically" do
    # Create posters with different names
    Poster.create(
      name: "REGRET",
      description: "Hard work rarely pays off.",
      price: 89.00,
      year: 2018,
      vintage: true,
      img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
    )
    
    Poster.create(
      name: "Last Resort",
      description: "Cut my life into pieces, this is my last resort.",
      price: 109.00,
      year: 2000,
      vintage: true,
      img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8"
    )
  
    Poster.create(
      name: "Potato",
      description: "You're a couch potato.",
      price: 3.00,
      year: 2014,
      vintage: true,
      img_url: "https://as1.ftcdn.net/v2/jpg/05/60/56/58/1000_F_560565861_F81rpaECDU1hxBMkfL5N7WOMoUGra9hw.jpg"
    )
  
    get '/api/v1/posters', params: { name: 'r' }
  
    json_response = JSON.parse(response.body, symbolize_names: true)
  
    posters = json_response[:data]
  
    expect(posters).to be_an(Array)
    expect(posters.size).to eq(2)
  
    expect(posters[0][:attributes][:name]).to eq("Last Resort")
    expect(posters[1][:attributes][:name]).to eq("REGRET")
  end
  
end 