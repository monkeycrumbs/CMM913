class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.text :title
      t.text :introduction
      t.timestamp :starts_at
      t.timestamp :ends_at
      t.integer :created_by

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
