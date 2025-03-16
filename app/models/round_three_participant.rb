class RoundThreeParticipant < ApplicationRecord
  belongs_to :engine
  belongs_to :tournament

	validates :engine_id, uniqueness: { scope: :tournament_id, message: "Engine is already in Round 3 for this tournament" }
end
