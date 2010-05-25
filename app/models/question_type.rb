class QuestionType < ActiveRecord::Base
  has_many :questions, :foreign_key => :type_id
end
