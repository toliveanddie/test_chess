class CreateRoundThreeParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :round_three_participants do |t|
      t.references :engine, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
