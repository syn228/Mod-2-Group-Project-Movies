class Character < ApplicationRecord
  has_many :roles
  has_many :actors, through: :roles
  has_many :appearances
  has_many :movies, through: :appearances
end
