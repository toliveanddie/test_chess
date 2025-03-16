class CreateEngines < ActiveRecord::Migration[8.0]
  def change
    create_table :engines do |t|
      t.string :name

      t.timestamps
    end
  end
end
