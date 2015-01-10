class CreateGlobes < ActiveRecord::Migration
  def change
    create_table :globes do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end
  end
end
