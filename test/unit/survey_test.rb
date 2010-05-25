require File.dirname(__FILE__) + '/../test_helper'

class SurveyTest < ActiveSupport::TestCase
  
  def test_status_for_closed_survey
    assert_equal "Closed", Survey.find(surveys(:closed).id).status
  end
  
  def test_status_for_open_survey
    assert_equal "Open", Survey.find(surveys(:survey_one).id).status
  end
  
  def test_survey_has_questions
    assert_equal 10, Survey.find(surveys(:survey_one).id).questions.count
  end
  
  def test_survey_questions_first_position
    assert_equal 1, Survey.find(surveys(:survey_one).id).questions.first.position
  end
  
  def test_survey_questions_last_position
    assert_equal 10, Survey.find(surveys(:survey_one).id).questions.last.position
  end
  
  def test_survey_should_require_title
    assert_no_difference 'Survey.count' do
      s = Survey.create
      assert s.errors.on(:title)
    end
  end
  
  def test_survey_send_invitations
    s = Survey.find(surveys(:invitation).id)
    assert_equal 2, s.invitations.find_all_by_response_and_mail_sent(false, false).size
    s.send_invitations
    assert_equal 0, s.invitations.find_all_by_response_and_mail_sent(false, false).size
  end
  
  def test_survey_should_send_follow_up
    s = Survey.find(surveys(:invitation).id)
    assert_equal 2, s.invitations.find_all_by_response_and_mail_sent(false, false).size
    s.send_invitations
    assert_equal 0, s.invitations.find_all_by_response_and_mail_sent(false, false).size
    assert_equal 2, s.invitations.find_all_by_response_and_mail_sent_and_follow_up_sent(false, true, false).size
    s.send_follow_up
    assert_equal 0, s.invitations.find_all_by_response_and_mail_sent_and_follow_up_sent(false, true, false).size
  end
  
end
