
class Actor < ApplicationRecord
  has_many :roles
  has_many :characters, through: :roles
  has_many :casts
  has_many :movies, through: :casts

  BASE_URL = "https://api.themoviedb.org/3/"
  SEARCH_URL = BASE_URL + "search/movie"
  PERSON_URL = BASE_URL + "person/"
  MOVIE_URL = BASE_URL + "movie/"
  API_KEY = "?api_key=945dbc0976d1fcb4db817690ca47fd3b"
  IMG_URL = "http://image.tmdb.org/t/p/w185"

  def get_actor_bio
    actor_json = RestClient.get("#{PERSON_URL}#{self.ext_actor_id}#{API_KEY}")
    actor_hash = JSON.parse(actor_json)
    actor_bio = actor_hash["biography"]
    actor_pic = actor_hash["profile_path"]
    self.update(bio: actor_bio, img: "#{IMG_URL}#{actor_pic}")
    self
    # Actor.find_by(name: parsed_actor["name"], bio: parsed_actor["biography"], img: "#{IMG_URL}#{parsed_actor["profile_path"]}" )
  end
end
