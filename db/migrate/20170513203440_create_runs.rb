class CreateRuns < ActiveRecord::Migration[5.1]
  def change
    create_table :runs do |t|
      t.date :date, null: false
      t.integer :duration, null: false
      t.integer :distance, null: false
      t.float :avg_speed, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
