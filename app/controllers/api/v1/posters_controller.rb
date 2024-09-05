class Api::V1::PostersController < ApplicationController
  def index
    # refactor
    # binding.pry
    # if params[:sort] == 'asc'
    #   posters = Poster.order(created_at: :asc)
    # elsif params[:sort] == 'desc'
    #   posters = Poster.order(created_at: :desc)
    # else
    #   posters = Poster.all
    # end

    posters = Poster.all
                          .sort_asc(params[:sort])
                          .sort_dsc(params[:sort])
    options = {}
    options[:meta] = {count: posters.length}
    render json: PosterSerializer.new(posters, options)
  end
  
  def show
    poster = Poster.find(params[:id])
    options = {}
    options[:meta] = {count: [poster].count}
    render json: PosterSerializer.new([ poster ], options)
  end

  def destroy
    Poster.delete(params[:id])
  end

  def create
    poster = Poster.create(poster_params)
    options = {}
    options[:meta] = {count: [poster].count}
    render json: PosterSerializer.new([poster],options)
  end

  def update 
    poster = Poster.find(params[:id])
    poster.update(poster_params)
    options = {}
    options[:meta] = {count: [poster].count}
    render json: PosterSerializer.new([poster],options)
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
  end 
end
