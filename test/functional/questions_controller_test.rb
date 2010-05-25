require File.dirname(__FILE__) + '/../test_helper'

class QuestionsControllerTest < ActionController::TestCase
  
  def test_should_get_index
    login_as :quentin
    get :index, :survey_id => surveys(:survey_one).id
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  def test_should_get_new
    login_as :quentin
    get :new, :survey_id => surveys(:survey_one).id
    assert_response :success
  end
  
  def test_should_display_question_types
    login_as :quentin
    get :new, :survey_id => surveys(:survey_one).id
    assert_response :success
    assert_select '#question_type_id', "text\ntextarea\nradio\nselect\ncheckbox\ndate\ncountry\nlikert\nnumber"
  end

  def test_should_create_question
    login_as :quentin
    assert_difference('Question.count') do
      post :create, :question => {:title => 'test title', :type_id => question_types(:text).id }, :survey_id => surveys(:survey_one).id
    end

    assert_redirected_to survey_question_path(surveys(:survey_one), assigns(:question))
  end

  def test_should_show_question
    login_as :quentin
    get :show, :id => questions(:string).id, :survey_id => surveys(:survey_one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :quentin
    get :edit, :id => questions(:string).id, :survey_id => surveys(:survey_one).id
    assert_response :success
  end

  def test_should_update_question
    login_as :quentin
    put :update, :id => questions(:string).id, :question => { }, :survey_id => surveys(:survey_one).id
    assert_redirected_to survey_question_path(surveys(:survey_one), assigns(:question))
  end

  def test_should_destroy_question
    login_as :quentin
    assert_difference('Question.count', -1) do
      delete :destroy, :id => questions(:string).id, :survey_id => surveys(:survey_one).id
    end

    assert_redirected_to survey_questions_path(surveys(:survey_one))
  end
  
  def test_should_move_position_down
    login_as :quentin
    assert_difference('Question.find(questions(:string).id).position') do
      post :down, :id => questions(:string).id, :survey_id => surveys(:survey_one).id
    end
  end
  
  def test_should_move_position_up
    login_as :quentin
    assert_difference('Question.find(questions(:string_required).id).position', -1) do
      post :up, :id => questions(:string_required).id, :survey_id => surveys(:survey_one).id
    end
  end
  
end
