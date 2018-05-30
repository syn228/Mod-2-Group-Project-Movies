class User < ApplicationRecord
  has_secure_password
  has_many :collections
  has_many :movies, through: :collections

  validates :username, presence: true, uniqueness: true
end
