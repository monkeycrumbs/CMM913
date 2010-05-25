require File.dirname(__FILE__) + '/../test_helper'

class InvitationTest < ActiveSupport::TestCase

  def test_token
    @invitation = Invitation.create( :email => 'test@test.com', :survey_id => 1 )
    assert_equal '6d0ac619a229a775a31ed2125244c1bdbb0869f7', @invitation.token
  end
  
  def test_invitation_should_require_email
   assert_no_difference 'Invitation.count' do
     i = Invitation.create()
     assert i.errors.on(:email)
   end
  end

  def test_unique_email_and_survey_id
    @invitation = Invitation.find(:first)
    assert_no_difference 'Invitation.count' do
      i = Invitation.create( :email => @invitation.email, :survey_id => @invitation.survey_id )
      assert_equal 'An invite for this survey already exists for this email address', i.errors.on(:email)
    end
  end
  
end
