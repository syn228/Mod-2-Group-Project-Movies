# This model class handles api calls to the moviedb server and extracts
# relevent information to parse into the local database for showing. 

class Movie < ApplicationRecord
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :casts
  has_many :actors, through: :casts
  has_many :collection
  has_many :users, through: :collection

  BASE_URL = "https://api.themoviedb.org/3/"
  SEARCH_URL = BASE_URL + "search/movie"
  PERSON_URL = BASE_URL + "person/"
  MOVIE_URL = BASE_URL + "movie/"
  API_KEY = "?api_key=945dbc0976d1fcb4db817690ca47fd3b"
  IMG_URL = "http://image.tmdb.org/t/p/w185/"

  def self.search(search_term)
    where("name LIKE ? OR genre LIKE ? OR producer LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
  end

  def self.search_movies(search_query)
    movie_results = RestClient.get("#{SEARCH_URL}#{API_KEY}&query=#{search_query}&page=1&include_adult=false")
    parsed_movies = JSON.parse(movie_results)
    parsed_movies["results"]
  end

  def self.get_movie_info(input)
    movie = RestClient.get("#{MOVIE_URL}#{input}#{API_KEY}&language=en-US")
    self.look_or_create_movie(JSON.parse(movie))
  end

  def get_character(movie_obj)
    casts = RestClient.get("#{MOVIE_URL}#{movie_obj["api_movie_id"]}/credits#{API_KEY}")
    pc = JSON.parse(casts)
    character_array = []
    if pc["cast"] != []
      pc["cast"].each_with_index do |character, index|
        break if index == 10
        char = Character.find_or_create_by(name: character["character"]) # We don't have character.bio nor character.alignment. Perhaps rid of it in the schema?
        actor = get_actor(movie_obj)
        char.movies << movie_obj
        character_array << character["character"]
      end

    #if pc["cast"] != []
    #  pc["cast"].each_with_index {|c, i|
    #    break if i == 10
    #    character_array << c["character"]
    #    @character = Character.find_or_create_by(name: c["character"])
    #}
    # @character.movies << movie_name
    roles = character_array.each {|c| c }
    return roles
  end
  else
    roles = []
  end

  def self.look_or_create_movie(movie_json)
    movie_title = movie_json["title"]
    movie_genre = movie_json["genres"].map { |genre| genre["name"] }.join(", ")
    movie_budget = movie_json["budget"]
    movie_production = movie_json["production_companies"].map {|production| production["name"]}.join(", ")
    ext_api_id = movie_json["id"]
    movie_obj = Movie.find_or_create_by(name: movie_title, genre: movie_genre, budget: movie_budget, producer: movie_production, api_movie_id: ext_api_id, img: "http://image.tmdb.org/t/p/w185/#{movie_json["poster_path"]}")
    get_character(movie_obj)
  end

  
  def self.get_actor(movie_obj)
    cast = RestClient.get("#{MOVIE_URL}#{movie_obj["api_movie_id"]}/credits#{API_KEY}")

    pc = JSON.parse(cast)
    actor_array = []
    pc["cast"].each_with_index do |castmember, index|
      break if index == 5
      actor_json = get_actor_bio(castmember["id"])
      actor_name = castmember["name"]

      actor_array << castmember["name"]
      @actor = Actor.find_or_create_by(name: actor_name, bio: actor_json["biography"], img: actor_json["profile_path"])
      movie_obj.actors << @actor
      # Movie.get_actor_bio(castmember["id"])
    end
    @actor.movies << movie_obj
    actor_array.each {|c| c }
  end

  def self.get_actor_bio(ext_actor_id)
    ac = RestClient.get("#{PERSON_URL}#{ext_actor_id}#{API_KEY}&language=en-US")
    JSON.parse(ac)
    # Actor.find_by(name: parsed_actor["name"], bio: parsed_actor["biography"], img: "#{IMG_URL}#{parsed_actor["profile_path"]}" )
  end

end
