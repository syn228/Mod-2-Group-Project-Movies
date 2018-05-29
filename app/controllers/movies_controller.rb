class MoviesController < ApplicationController
  before_action :get_movie, only: [:show, :create, :update, :destroy]
  before_action :all_actors, only: [:new, :edit]
  before_action :all_characters, only: [:new, :edit]
  def new
    @movie = Movie.new
  end

  def index
    @movies = Movie.all
  end

  def show
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie.valid?
      redirect_to @movie
    else
      flash[:errors] = @movie.errors.full_messages
      redirect_to new_movie_path
    end
  end

  def edit
  end

  def update
    @movie.update(movie_params)
    if @movie.valid?
      redirect_to @movie
    else
      flash[:errors] = @movie.errors.full_messages
      redirect_to edit_movie_path
    end
  end


  private

  def movie_params
    params.require(:movie).permit(:name, :genre, :buget, :producer, :api_movie_id, actor_ids:[], character_ids:[])
  end

  def get_movie
    @movie = Movie.find(params[:id])
  end

  def all_actors
    @actors = Actor.all
  end

  def all_characters
    @characters = Character.all
  end

end
