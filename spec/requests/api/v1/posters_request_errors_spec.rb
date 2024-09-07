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

end