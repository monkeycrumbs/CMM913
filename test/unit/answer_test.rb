require File.dirname(__FILE__) + '/../test_helper'

class AnswerTest < ActiveSupport::TestCase
  
  def test_answer_is_not_mandatory
    a = Answer.find(answers(:one))
    assert ! a.mandatory?, "answer is mandatory"
  end
  
  def test_answer_is_mandatory
    a = Answer.find(answers(:required))
    assert a.mandatory?, "answer is not mandatory"
  end
  
  def test_answer_should_require_answer
    assert_no_difference 'Answer.count' do
     a = Answer.create(:question_id => Question.find(questions(:string_required)).id)
     assert a.errors.on(:answer)
    end
  end
  
  def test_answer_is_numeric
    a = Answer.find(answers(:number_answer))
    assert a.number?, "answer is not a number"
  end
  
  def test_answer_is_not_numeric
    a = Answer.find(answers(:one))
    assert ! a.number?, "answer is a number"
  end
  
  def test_answer_should_require_number
    assert_no_difference 'Answer.count' do
      a = Answer.create(:question_id => Question.find(questions(:number)).id, :answer => 'Not a number' )
      assert a.errors.on(:answer)
    end
  end
  
end
