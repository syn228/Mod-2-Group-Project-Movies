class ActorsController < ApplicationController
  before_action :get_actor, only: [:show, :create, :update, :destroy]
  before_action :all_movies, only: [:new, :edit]
  before_action :all_characters, only: [:new, :edit]
  def new
    @actor = Actor.new
  end

  def index
    @actors = Actor.all
  end

  def show
  end

  def create
    @actor = Actor.create(actor_params)
    if @actor.valid?
      redirect_to @actor
    else
      flash[:errors] = @actor.errors.full_messages
      redirect_to new_actor_path
    end
  end

  def edit
  end

  def update
    @actor.update(actor_params)
    if @actor.valid?
      redirect_to @actor
    else
      flash[:errors] = @actor.errors.full_messages
      redirect_to edit_actor_path
    end
  end


  private

  def actor_params
    params.require(:actor).permit(:name, :bio, movie_ids:[], character_ids:[])
  end

  def get_actor
    @actor = Actor.find(params[:id])
  end

  def all_movies
    @movies = Movie.all
  end

  def all_characters
    @characters = Character.all
  end
end
