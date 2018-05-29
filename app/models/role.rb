class Role < ApplicationRecord
  belongs_to :actor
  belongs_to :character
end
