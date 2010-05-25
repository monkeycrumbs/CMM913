class AddOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.integer :question_id
      t.string  :label
    end
  end

  def self.down
    drop_table :options
  end
end
