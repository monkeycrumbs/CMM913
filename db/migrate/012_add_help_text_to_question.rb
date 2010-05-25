class AddHelpTextToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :help_text, :string
  end

  def self.down
    remove_column :questions, :help_text
  end
end
