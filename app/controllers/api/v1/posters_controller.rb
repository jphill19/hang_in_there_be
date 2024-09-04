class Api::V1::PostersController < ApplicationController
  def index
    if params[:sort] == 'asc'
      posters = Poster.order(created_at: :asc)
    elsif params[:sort] == 'desc'
      posters = Poster.order(created_at: :desc)
    else
      posters = Poster.all
    end
    render json: PosterSerializer.format_posters(posters)
  end
  
  def show
    poster = Poster.find(params[:id])
    render json: PosterSerializer.format_posters([ poster ])
  end

  def destroy
    render json: Poster.delete(params[:id])
  end

  def create
    poster = Poster.create(poster_params)
    render json: PosterSerializer.format_posters([poster])
  end

  def update 
    poster = Poster.find(params[:id])
    poster.update(poster_params)
    render json: PosterSerializer.format_posters([poster])
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
  end 
end
