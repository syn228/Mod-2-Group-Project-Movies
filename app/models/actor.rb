class Actor < ApplicationRecord
  has_many :roles
  has_many :characters, through: :roles
  has_many :casts
  has_many :movies, through: :casts
end
