class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.float :latitude
      t.float :longitude
      t.float :magnitude
      t.integer :legend
      t.references :globe, unique: true, index: true

      t.timestamps null: false
    end
  end
end
