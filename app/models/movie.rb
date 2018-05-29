class Movie < ApplicationRecord
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :casts
  has_many :actors, through: :casts
end
