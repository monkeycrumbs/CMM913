class Response < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, :dependent => :destroy
  belongs_to :user
  validates_associated :answers
  validates_presence_of :survey_id

#  def save(args)
#    super(args)
#  rescue ActiveRecord::RecordInvalid => invalid
#    puts invalid.record.errors
#    false
#  end
end