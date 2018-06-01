class CharactersController < ApplicationController
  before_action :get_character, only: [:show, :create, :update, :destroy]
  before_action :all_actors, only: [:new, :edit]
  before_action :all_characters, only: [:new, :edit]
  def new
    @character = Character.new
  end

  def index
    @characters = Character.all
  end

  def show
    byebug
  end

  def create
    # @character = Character.create(character_params)
    # if @character.valid?
    #   redirect_to @character
    # else
    #   flash[:errors] = @character.errors.full_messages
    #   redirect_to new_character_path
    # end
  end

  def edit
  end

  def update
    # @character.update(character_params)
    # if @character.valid?
    #   redirect_to @character
    # else
    #   flash[:errors] = @character.errors.full_messages
    #   redirect_to edit_character_path
    # end
  end


  private

  def character_params
    params.require(:character).permit(:name, :bio, movie_ids:[], actor_ids:[])
  end

  def get_character
    @character = Character.find(params[:id])
  end

  def all_movies
    @movies = Movie.all
  end

  def all_actors
    @actors = Actor.all
  end

end
