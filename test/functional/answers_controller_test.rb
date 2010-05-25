require File.dirname(__FILE__) + '/../test_helper'

class AnswersControllerTest < ActionController::TestCase
  
  def test_should_get_index
    login_as :quentin
    get :index, :question_id => questions(:string).id
    assert_response :success
    assert_not_nil assigns(:answers)
  end

  def test_should_get_new
    login_as :quentin
    get :new, :question_id => questions(:string).id
    assert_response :success
  end

  def test_should_create_answer
    login_as :quentin
    assert_difference('Answer.count') do
      post :create, :answer => { }, :question_id => questions(:string).id
    end

    assert_redirected_to question_answer_path(questions(:string).id, assigns(:answer))
  end

  def test_should_show_answer
    login_as :quentin
    get :show, :id => answers(:one).id, :question_id => questions(:string).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :quentin
    get :edit, :id => answers(:one).id, :question_id => questions(:string).id
    assert_response :success
  end

  def test_should_update_answer
    login_as :quentin
    put :update, :id => answers(:one).id, :answer => { }, :question_id => questions(:string).id
    assert_redirected_to question_answer_path(questions(:string).id, assigns(:answer))
  end

  def test_should_destroy_answer
    login_as :quentin
    assert_difference('Answer.count', -1) do
      delete :destroy, :id => answers(:one).id, :question_id => questions(:string).id
    end

    assert_redirected_to question_answers_path(questions(:string).id)
  end
end
