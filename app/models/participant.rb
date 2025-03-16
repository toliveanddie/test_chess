class Participant < ApplicationRecord
  belongs_to :engine
  belongs_to :tournament
end
