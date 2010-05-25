require File.dirname(__FILE__) + '/../test_helper'

class SurveysControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :quentin
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  def test_should_get_new
    login_as :quentin
    get :new
    assert_response :success
  end

  def test_should_create_survey
    login_as :quentin
    assert_difference('Survey.count') do
      post :create, :survey => { :title => 'test title' }
    end

    assert_redirected_to survey_path(assigns(:survey))
    assert_equal 'Survey was successfully created.', flash[:notice]
  end
  
  def test_should_require_title
    login_as :quentin
    assert_no_difference('Survey.count') do
      post :create, :survey => { }
    end
    assert_select 'h2', '1 error prohibited this survey from being saved'
    assert_select 'div#errorExplanation ul li', :text => 'Title can\'t be blank'
    assert_template 'new'
  end

  def test_should_show_survey
    login_as :quentin
    get :show, :id => surveys(:survey_one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :quentin
    get :edit, :id => surveys(:survey_one).id
    assert_response :success
  end

  def test_should_update_survey
    login_as :quentin
    put :update, :id => surveys(:survey_one).id, :survey => { }
    assert_redirected_to survey_path(assigns(:survey))
  end

  def test_should_destroy_survey
    login_as :quentin
    assert_difference('Survey.count', -1) do
      delete :destroy, :id => surveys(:survey_one).id
    end

    assert_redirected_to surveys_path
  end
  
end
