class AddMandatoryToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :mandatory, :boolean
  end

  def self.down
    remove_column :questions, :mandatory
  end
end
