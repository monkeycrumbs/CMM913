require File.dirname(__FILE__) + '/../test_helper'

class OptionsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :quentin
    get :index, :question_id => questions(:checkbox).id
    assert_response :success
    assert_not_nil assigns(:options)
  end

  def test_should_get_new
    login_as :quentin
    get :new, :question_id => questions(:checkbox).id
    assert_response :success
  end

  def test_should_create_option
    login_as :quentin
    assert_difference('Option.count') do
      post :create, :option => { :label => options(:checkbox_one).label }, :question_id => questions(:checkbox).id
    end

    assert_redirected_to question_option_path(questions(:checkbox), assigns(:option))
  end

  def test_should_show_option
    login_as :quentin
    get :show, :id => options(:checkbox_one).id, :question_id => questions(:checkbox).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :quentin
    get :edit, :id => options(:checkbox_one).id, :question_id => questions(:checkbox).id
    assert_response :success
  end

  def test_should_update_option
    login_as :quentin
    put :update, :id => options(:checkbox_one).id, :option => { }, :question_id => questions(:checkbox).id
    assert_redirected_to question_option_path(questions(:checkbox), assigns(:option))
  end

  def test_should_destroy_option
    login_as :quentin
    assert_difference('Option.count', -1) do
      delete :destroy, :id => options(:checkbox_one).id, :question_id => questions(:checkbox).id
    end

    assert_redirected_to question_options_path(questions(:checkbox)  )
  end
  
  def test_should_move_position_down
    login_as :quentin
    assert_difference('Option.find(options(:checkbox_one).id).position') do
      post :down, :id => options(:checkbox_one).id, :question_id => questions(:checkbox).id
    end
  end
  
  def test_should_move_position_up
    login_as :quentin
    assert_difference('Option.find(options(:checkbox_two).id).position', -1) do
      post :up, :id => options(:checkbox_two).id, :question_id => questions(:checkbox).id
    end
  end
  
end