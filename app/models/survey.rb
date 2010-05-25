class Survey < ActiveRecord::Base
  belongs_to :user, :foreign_key => :created_by
  belongs_to :survey_type
  has_many :questions, :order => "position", :dependent => :destroy
  has_many :responses, :dependent => :destroy
  has_many :invitations, :dependent => :destroy
  
  validates_presence_of :title
  
  # return open or closed
  def status
    ((starts_at..ends_at).include? Time.now) ? 'Open' : 'Closed'
  end
  
  # check invitation token exists and has not been used
  def check_token(token)
    !self.invitations.find_by_token_and_response(token, false).nil?
  end
  
  # set response to true after invited response is complete
  def update_invitation(token)
    i = self.invitations.find_by_token(token)
    i.response = true
    i.save
  end
  
  # send email invitations
  def send_invitations
    # send only to those who have not responded and who have not previously been sent an invitation
    self.invitations.find_all_by_response_and_mail_sent(false, false).each do |invite|
      InvitationMailer.deliver_invite(invite)
      invite.mail_sent = true
      invite.save
    end
  end
  
  # send a follow up email to those have been invited but not yet responded
  def send_follow_up
    # send to those who have not responded, been sent a mail and not been sent a follow up
    self.invitations.find_all_by_response_and_mail_sent_and_follow_up_sent(false, true, false).each do |follow_up|
      InvitationMailer.deliver_follow_up(follow_up)
      follow_up.follow_up_sent = true
      follow_up.save
    end
  end
  
  # returns an array of all survey answers for export to csv
  def export_answers   
    answers = Array.new
    self.responses.each do |r|
      r.answers.each do |a|
        answers << a
      end
    end
    answers
  end
  
end
