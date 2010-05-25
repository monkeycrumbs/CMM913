require File.dirname(__FILE__) + '/../test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  tests InvitationMailer
  fixtures :invitations
  def test_invite
    @expected.subject = 'Your invited to take part in a survey'
    @expected.body    = read_fixture('invite')
    @expected.from    = 'invite@cmmm913-survey.net'
    @expected.to      = invitations(:one).email
    @expected.date    = Time.now

    assert_equal @expected.encoded, InvitationMailer.create_invite(invitations(:one), @expected.date).encoded
  end

  def test_follow_up
    @expected.subject = 'Survey reminder'
    @expected.body    = read_fixture('follow_up')
    @expected.from    = 'invite@cmmm913-survey.net'
    @expected.to      = invitations(:one).email
    @expected.date    = Time.now

    assert_equal @expected.encoded, InvitationMailer.create_follow_up(invitations(:one), @expected.date).encoded
  end

end
