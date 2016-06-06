class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :query
      t.text :concat
      t.string :userid

      t.timestamps null: false
    end
  end
end
