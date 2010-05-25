class AddThankYouMessageToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :thank_you_message, :text
  end

  def self.down
    remove_column :surveys, :thank_you_message
  end
end
