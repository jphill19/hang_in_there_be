require 'rails_helper'

describe "Posters API errors" do
  it "will reply with a JSON error response, for invalid IDs" do
    id = Poster.create(name: "Last Resort",
    description: "Cut my life into pieces, this is my last resort.",
    price: 109.00,
    year: 2000,
    vintage: true,
    img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8").id

    get "/api/v1/posters/#{id + 1}"

    expect(response).to have_http_status(404)
    poster = JSON.parse(response.body, symbolize_names: true)

    poster_error = poster[:errors].first

    expect(poster_error). to have_key(:status)
    expect(poster_error[:status]).to eq("404")

    expect(poster_error). to have_key(:message)
    expect(poster_error[:message]).to eq("Record not found")
  end

  it "will give a JSON response error, when missing attributes" do
    poster_params = {
      name: "",
      description: "",
      price: "test",
      year: "fail",
      vintage: "",
      img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8"
    }
  
    headers = { "CONTENT_TYPE" => "application/json" }
  
    post "/api/v1/posters", headers: headers, params: JSON.generate(poster_params)

    expect(response).to have_http_status(422)
    poster = JSON.parse(response.body, symbolize_names: true)

    poster_error = poster[:errors]

    expect(poster_error[0]). to have_key(:status)
    expect(poster_error[0][:status]).to eq("422")

    expect(poster_error[0]). to have_key(:message)
    expect(poster_error[0][:message]).to eq("Name can't be blank")
   
    expect(poster_error[1]). to have_key(:status)
    expect(poster_error[1][:status]).to eq("422")

    expect(poster_error[1]). to have_key(:message)
    expect(poster_error[1][:message]).to eq("Description can't be blank")

    expect(poster_error[2]). to have_key(:status)
    expect(poster_error[2][:status]).to eq("422")

    expect(poster_error[2]). to have_key(:message)
    expect(poster_error[2][:message]).to eq("Year is not a number")

    expect(poster_error[3]). to have_key(:status)
    expect(poster_error[3][:status]).to eq("422")

    expect(poster_error[3]). to have_key(:message)
    expect(poster_error[3][:message]).to eq("Price is not a number")

    expect(poster_error[4]). to have_key(:status)
    expect(poster_error[4][:status]).to eq("422")

    expect(poster_error[4]). to have_key(:message)
    expect(poster_error[4][:message]).to eq("Vintage is not included in the list")

    expect(poster_error[5]). to have_key(:status)
    expect(poster_error[5][:status]).to eq("422")

    expect(poster_error[5]). to have_key(:message)
    expect(poster_error[5][:message]).to eq("Vintage is reserved")
  end

  it "will give a JSON response error, if name already exists and year/price are not present" do
    Poster.create(name: "Last Resort",
    description: "Cut my life into pieces, this is my last resort.",
    price: 109.00,
    year: 2000,
    vintage: true,
    img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8")

    poster_params = {
      name: "Last Resort",
      description: "Hi",
      price: "",
      year: "",
      vintage: true,
      img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8"
    }

    headers = { "CONTENT_TYPE" => "application/json" }
  
    post "/api/v1/posters", headers: headers, params: JSON.generate(poster_params)

    expect(response).to have_http_status(422)
    poster = JSON.parse(response.body, symbolize_names: true)
    
    poster_error = poster[:errors]

    expect(poster_error[0]). to have_key(:status)
    expect(poster_error[0][:status]).to eq("422")

    expect(poster_error[0]). to have_key(:message)
    expect(poster_error[0][:message]).to eq("Name has already been taken")
   
    expect(poster_error[1]). to have_key(:status)
    expect(poster_error[1][:status]).to eq("422")

    expect(poster_error[1]). to have_key(:message)
    expect(poster_error[1][:message]).to eq("Year can't be blank")

    expect(poster_error[2]). to have_key(:status)
    expect(poster_error[2][:status]).to eq("422")

    expect(poster_error[2]). to have_key(:message)
    expect(poster_error[2][:message]).to eq("Year is not a number")

    expect(poster_error[3]). to have_key(:status)
    expect(poster_error[3][:status]).to eq("422")

    expect(poster_error[3]). to have_key(:message)
    expect(poster_error[3][:message]).to eq("Price can't be blank")

    expect(poster_error[4]). to have_key(:status)
    expect(poster_error[4][:status]).to eq("422")

    expect(poster_error[4]). to have_key(:message)
    expect(poster_error[4][:message]).to eq("Price is not a number")
  end

  it "will give a JSON response error, if name already exists" do
    id = Poster.create(
      name: "People will dislike you",
      description: "Cut my life into pieces, this is my last resort.",
      price: 109.00,
      year: 2000,
      vintage: true,
      img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8"
      ).id

    poster_params = {
      name: "",
      description: "No matter how hard you try, you will never be able to please everyone",
      price: 153.00,
      year: 1995,
      vintage: true,
      img_url: "https://media.licdn.com/dms/image/C4E12AQGjklvrQy5SqA/article-cover_image-shrink_600_2000/0/1607974565714?e=2147483647&v=beta&t=4o5OEtO3oXD3szr9M3O1lbzWtMR9pXvSXFnySH2Kd_8"
    }

    headers = { "CONTENT_TYPE" => "application/json" }
  
    patch "/api/v1/posters/#{id}", headers: headers, params: JSON.generate(poster_params)
    
    expect(response).to have_http_status(422)
    poster = JSON.parse(response.body, symbolize_names: true)
   
    poster_error = poster[:errors].first

    expect(poster_error). to have_key(:status)
    expect(poster_error[:status]).to eq("422")

    expect(poster_error). to have_key(:message)
    expect(poster_error[:message]).to eq("Name can't be blank")
  end
end