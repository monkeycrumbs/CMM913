class Option < ActiveRecord::Base
  belongs_to :question
  has_many :answers
  validates_presence_of :label
  acts_as_list :scope => :question
  
end
