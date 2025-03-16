class Engine < ApplicationRecord
  has_many :participants
  has_many :tournaments, through: :participants
	has_many :round_two_participants

	has_many :round_three_participants
  has_many :round_three_tournaments, through: :round_three_participants, source: :tournament

end
