class GeneralsController < ApplicationController

  def home
  end

  def index
    if params[:search]
      @movies = Movie.search(params[:search]).order("created_at DESC")
      @characters = Character.search(params[:search]).order("created_at DESC")
      @actors = Actor.search(params[:search]).order("created_at DESC")
    else
      @movies = Movie.all.order("created_at DESC")
      @characters = Character.all.order("created_at DESC")
      @actors = Actor.all.order("created_at DESC")
    end
  end
end
