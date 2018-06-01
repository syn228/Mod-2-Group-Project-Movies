class Movie < ApplicationRecord
    has_many :appearances
    has_many :characters, through: :appearances
    has_many :casts
    has_many :actors, through: :casts
    has_many :collection
    has_many :users, through: :collection

    BASE_URL = "https://api.themoviedb.org/3/"
    API_KEY = "945dbc0976d1fcb4db817690ca47fd3b"

    