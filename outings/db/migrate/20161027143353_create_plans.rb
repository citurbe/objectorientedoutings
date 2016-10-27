class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.integer :location_id
      t.integer :organizer_id
      t.datetime :timing

      t.timestamps
    end
  end
end
