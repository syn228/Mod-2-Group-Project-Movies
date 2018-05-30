class Movie < ApplicationRecord
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :casts
  has_many :actors, through: :casts

  def self.search(search)
  where("name LIKE ? OR genre LIKE ? OR producer LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def self.search_movies(input)
    movie_results = RestClient.get("https://api.themoviedb.org/3/search/movie?api_key=945dbc0976d1fcb4db817690ca47fd3b&language=en-US&query=#{input}&page=1&include_adult=false")

    parsed_movies = JSON.parse(movie_results)
    movie_result = parsed_movies["results"]
    return movie_result
  end

  def self.get_movie_info(input)
    movie = RestClient.get("https://api.themoviedb.org/3/movie/#{input}?api_key=945dbc0976d1fcb4db817690ca47fd3b&language=en-US")
    parsed_movie = JSON.parse(movie)

    movie_title = parsed_movie["title"]
    movie_genre = parsed_movie["genres"].map { |genre| genre["name"] }.join(", ")
    movie_budget = parsed_movie["budget"]
    movie_production = parsed_movie["production_companies"].map {|production| production["name"]}.join(", ")
    Movie.find_or_create_by(name: movie_title, genre: movie_genre, budget: movie_budget, producer: movie_production, api_movie_id: input)
  end

  def get_character(input, movie_name)
    cast = RestClient.get("https://api.themoviedb.org/3/movie/#{input}/credits?api_key=945dbc0976d1fcb4db817690ca47fd3b")
    parsed_cast = JSON.parse(cast)
    character_array = []
    parsed_cast["cast"].each {|c|
      character_array << c["character"]
      @character = Character.find_or_create_by(name: c["character"])
    }
    @character.movies << movie_name
    roles = character_array.each {|c| c }
    return roles

  end

  def get_actor(input, movie_name)
    cast = RestClient.get("https://api.themoviedb.org/3/movie/#{input}/credits?api_key=945dbc0976d1fcb4db817690ca47fd3b")
    parsed_cast = JSON.parse(cast)
    actor_array = []
    parsed_cast["cast"].each_with_index {|c, i|
      break if i == 15
      actor_array << c["name"]
      @actor = Actor.find_or_create_by(name: c["name"])
      Movie.get_actor_bio(c["id"])
    }
    @actor.movies << movie_name
    roles = actor_array.each {|c| c }
    return roles
  end

  def self.get_actor_bio(input)
    ac = RestClient.get("https://api.themoviedb.org/3/person/#{input}?api_key=945dbc0976d1fcb4db817690ca47fd3b&language=en-US")
    parsed_actor = JSON.parse(ac)
    a_bio = parsed_actor["biography"]
    a = Actor.find_by(name: parsed_actor["name"])
    a.update(bio: a_bio)
  end
end
