class Tournament < ApplicationRecord
	validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }

	has_many :participants
  has_many :engines, through: :participants
	has_many :round_two_participants

	has_many :round_three_participants
  has_many :round_three_engines, through: :round_three_participants, source: :engine

end
