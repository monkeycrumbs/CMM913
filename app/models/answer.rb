class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :response
  belongs_to :option
  
  validates_presence_of :answer, :if => :mandatory?
  validates_numericality_of :answer, :if => :number?
  validates_confirmation_of :answer, :if => :confirmation?
  
  # boolean for answer validation
  def mandatory?
    question.mandatory
  end
  
  # boolean for number validation
  def number?
    question.type == 'number'
  end
  
  # boolean for confirmation validation
  def confirmation?
    question.type == 'confirmation'
  end
  
end
