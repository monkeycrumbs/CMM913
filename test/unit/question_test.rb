require File.dirname(__FILE__) + '/../test_helper'

class QuestionTest < ActiveSupport::TestCase
  
 def setup
   @q = Question.find(questions(:string))
 end

 def test_question_label
   assert_equal "question_id_#{@q.id}", @q.label_id
 end
 
 def test_question_type
   assert_equal "text", @q.type
 end
 
 def test_question_partial
   assert_equal "global/text", @q.partial
 end
 
 def test_question_should_require_title
   assert_no_difference 'Question.count' do
     q = Question.create(:type_id => QuestionType.find(question_types(:text).id))
     assert q.errors.on(:title)
   end
 end
 
 def test_question_should_require_type
   assert_no_difference 'Question.count' do
     q = Question.create(:title => "Question title")
     assert q.errors.on(:type_id)
   end
 end
 
 def test_question_answer_total
   q = create_question
   assert_equal 28, q.answer_total
 end
   
 
 def test_question_answer_median
   q = create_question
   assert_equal 4, q.answer_median
 end

  def test_question_answer_mean
   q = create_question
   assert_equal 4, q.answer_mean 
 end
 
  def test_question_answer_mode
   q = create_question
   assert_equal 2, q.answer_mode 
 end
 
 def test_new_options_attributes
   q=Question.new(:title=>'title', :type_id =>1)
   q.new_option_attributes=(['label' => 'test'])
   assert_equal 1, q.options.size
 end
 
protected 
 def create_question
   q = Question.create(:title => "Average Test", :type_id => QuestionType.find_by_name("number").id )
   q.save
   q.reload
   ['2', '2', '4', '6', '2', '8', '4'].each do |a|
     q.answers << Answer.new(:answer => a )
   end
   q.save
   q.reload
 end
 
end
