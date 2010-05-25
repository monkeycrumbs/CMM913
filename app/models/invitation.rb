class Invitation < ActiveRecord::Base
  belongs_to :survey
  before_save :set_token
  validates_presence_of :email
  validates_uniqueness_of :email, :scope => :survey_id, :message => "An invite for this survey already exists for this email address"
  
  # create unique invitation token before saving
  def set_token
    self.token = Digest::SHA1.hexdigest("--#{email}--#{survey_id}--")
  end
end
