class ChangeDataTypeForScore < ActiveRecord::Migration
  def self.up
    change_table :results do |t|
      t.change :score, :float
    end
		



  end
  def self.down
    change_table :results do |t|
      t.change :score, :string
    end
		
  end
end
