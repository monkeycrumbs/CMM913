class InvitationMailer < ActionMailer::Base
  
  default_url_options[:host] = 'localhost:3000'

  # send survey invitation email
  def invite(invitation, sent_at = Time.now)
    @subject    = 'Your invited to take part in a survey'
    @body       = { :invitation => invitation }
    @recipients = invitation.email
    @from       = 'invite@cmmm913-survey.net'
    @sent_on    = sent_at
    @headers    = {}
  end

  # send follow up email for survey invitation
  def follow_up(invitation, sent_at = Time.now)
    @subject    = 'Survey reminder'
    @body       = { :invitation => invitation }
    @recipients = invitation.email
    @from       = 'invite@cmmm913-survey.net'
    @sent_on    = sent_at
    @headers    = {}
  end
end
