class Room < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :messages
end
