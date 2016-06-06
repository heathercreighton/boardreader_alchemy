class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :qid
      t.datetime :pub_date
      t.text :url
      t.text :clean_text
      t.float :score
      t.string :source

      t.timestamps null: false
    end
  end
end
