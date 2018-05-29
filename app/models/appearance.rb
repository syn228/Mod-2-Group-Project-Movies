class Appearance < ApplicationRecord
  belongs_to :character
  belongs_to :movie
end
