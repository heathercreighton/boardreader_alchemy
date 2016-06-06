class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :ticker
      t.string :company
      t.datetime :date
      t.text :url
      t.string :senttype
      t.string :score

      t.timestamps null: false
    end
  end
end
