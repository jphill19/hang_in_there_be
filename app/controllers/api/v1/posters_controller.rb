class Api::V1::PostersController < ApplicationController
  def index
    posters = Poster.all
                          .filter_by_name(params[:name])
                          .sort_asc(params[:sort])
                          .sort_dsc(params[:sort])
                          .filter_by_min_price(params[:min_price])
                          .filter_by_max_price(params[:max_price])
    options = {}
    options[:meta] = {count: posters.length}
    render json: PosterSerializer.new(posters, options)
  end
  
  def show
    begin
      poster = Poster.find(params[:id])
      render json: PosterSerializer.new(poster)
    rescue ActiveRecord::RecordNotFound
      render json: {
        errors: [
          {
            status: "404",
            message: "Record not found"
          }
        ]
      }, status: 404
    end
  end

  def destroy
    Poster.delete(params[:id])
    render nothing: true, status: 204
  end

  def create
    poster = Poster.create(poster_params)
    # binding.pry
    if poster.errors.count > 0
      error_response(poster)  
      return
    end
    render json: PosterSerializer.new(poster)
  end

  def update 
    poster = Poster.find(params[:id])
    poster.update(poster_params)
    if poster.errors.count > 0
      error_response(poster)
      return
    end
    render json: PosterSerializer.new(poster)
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
  end 

  def error_response(poster)
    if poster.errors.count > 0
      render json: {
        errors: poster.errors.full_messages.map do |msg|
          {
            status: "422",
            message: msg
          }
        end
      }, status: 422
      return
    end
  end
end
