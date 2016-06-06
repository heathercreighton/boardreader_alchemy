class AddUrltextToResults < ActiveRecord::Migration
  def change
    add_column :results, :urltext, :text
  end
end
