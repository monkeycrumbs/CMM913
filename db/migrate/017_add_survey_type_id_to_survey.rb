class AddSurveyTypeIdToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :survey_type_id, :integer
  end

  def self.down
    remove_column :surveys, :survey_type_id
  end
end
