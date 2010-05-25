require File.dirname(__FILE__) + '/../test_helper'

class ResponsesControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :quentin
    get :index, :survey_id => surveys(:survey_one).id
    assert_response :success
    assert_not_nil assigns(:responses)
  end

  def test_should_get_new
    login_as :quentin
    get :new, :survey_id => surveys(:survey_one).id
    assert_response :success
  end
  
  def test_help_text_is_displayed
    login_as :quentin
    get :new, :survey_id => surveys(:survey_one).id
    assert_response :success
    assert_select 'div#question_645912946 span.info', :text => 'Help text one'
  end
  
  def test_required_marker_is_displayed
    login_as :quentin
    get :new, :survey_id => surveys(:survey_one).id
    assert_select 'div#question_591412650 label span.required', :text => '*'
  end
  
  def test_input_ids
    login_as :quentin
    get :new, :survey_id => surveys(:survey_one).id
    assert_response :success
    assert_select 'div#question_645912946 input#question_id_645912946' # text
    assert_select 'div#question_591412650 input#question_id_591412650' # textarea
    assert_select 'div#question_339857043 textarea#question_id_339857043' # textarea
    assert_select 'div#question_540503127 select#question_id_540503127_year' # year
    assert_select 'div#question_540503127 select#question_id_540503127_month' # month
    assert_select 'div#question_540503127 select#question_id_540503127_day' # day
    assert_select 'div#question_804363243 select#question_id_804363243_country' # country
    assert_select 'div#question_905967551 input#question_id_905967551_245809336' # checkbox option one
    assert_select 'div#question_905967551 input#question_id_905967551_202602100' # checkbox option two
    assert_select 'div#question_311329782 input#question_id_311329782_option_radio_one' #radio option one
    #assert_select 'div# input#' #
    #assert_select 'div# input#' #
    #assert_select 'div# input#' #
  end
  
  def test_input_names
    login_as :quentin
    get :new, :survey_id => surveys(:survey_one).id
    assert_response :success
    assert_select 'form[action=?]', survey_responses_path do
      assert_select 'input[type=text][name=?]', 'question_id_645912946'
      assert_select 'input[type=checkbox][name=?]', 'question_id_905967551_[245809336]'
      assert_select 'input[type=radio][name=?]', 'question_id_311329782[option]'
      assert_select 'select[name=?]', 'question_id_540503127[year]'
    end
  end

  def test_should_create_response
    login_as :quentin
    assert_difference('Response.count') do
      post :create, :response => { }, :survey_id => surveys(:survey_one).id
    end

    assert_redirected_to survey_response_path(surveys(:survey_one).id, assigns(:response))
  end

  def test_should_show_response
    login_as :quentin
    get :show, :id => responses(:one).id, :survey_id => surveys(:survey_one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :quentin
    get :edit, :id => responses(:one).id, :survey_id => surveys(:survey_one).id
    assert_response :success
  end

  def test_should_update_response
    login_as :quentin
    put :update, :id => responses(:one).id, :response => { }, :survey_id => surveys(:survey_one).id
    assert_redirected_to survey_response_path(surveys(:survey_one).id, assigns(:response))
  end

  def test_should_destroy_response
    login_as :quentin
    assert_difference('Response.count', -1) do
      delete :destroy, :id => responses(:one).id, :survey_id => surveys(:survey_one).id
    end

    assert_redirected_to survey_responses_path(surveys(:survey_one).id)
  end
  
  def test_should_get_new_for_public_survey
    get :new, :survey_id => surveys(:public).id
    assert_response :success
  end
  
  def test_should_require_login_for_private_survey
    get :new, :survey_id => surveys(:private).id
    assert_response :redirect
  end
  
  def test_should_get_new_for_invitation_survey
    get :new, :survey_id => surveys(:invitation).id, :token => invitations(:one).token
    assert_response :success
  end
  
  def test_survey_should_be_closed
    get :new, :survey_id => surveys(:closed).id
    assert_template '_survey_closed'
  end
  
end
