class Api::V1::PostersController < ApplicationController
  def index
    posters = Poster.all
                          .sort_asc(params[:sort])
                          .sort_dsc(params[:sort])
                          .filter_by_name(params[:name])
                          .filter_by_min_price(params[:min_price])
                          .filter_by_max_price(params[:max_price])
    options = {}
    options[:meta] = {count: posters.length}
    render json: PosterSerializer.new(posters, options)
  end
  
  def show
    poster = Poster.find(params[:id])
    render json: PosterSerializer.new(poster)
  end

  def destroy
    Poster.delete(params[:id])
    render nothing: true, status: 204
  end

  def create
    poster = Poster.create(poster_params)
    render json: PosterSerializer.new(poster)
  end

  def update 
    poster = Poster.find(params[:id])
    poster.update(poster_params) 
    render json: PosterSerializer.new(poster)
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
  end 
end
