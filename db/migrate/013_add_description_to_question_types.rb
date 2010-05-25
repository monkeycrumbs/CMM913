class AddDescriptionToQuestionTypes < ActiveRecord::Migration
  def self.up
    add_column :question_types, :description, :text
  end

  def self.down
    remove_column :question_types, :description
  end
end
