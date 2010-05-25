require File.dirname(__FILE__) + '/../test_helper'

class InvitationsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :quentin
    get :index, :survey_id => surveys(:invitation).id
    assert_response :success
    assert_not_nil assigns(:invitations)
  end

  def test_should_get_new
    login_as :quentin
    get :new, :survey_id => surveys(:invitation).id
    assert_response :success
  end

  def test_should_create_invitation
    login_as :quentin
    assert_difference('Invitation.count') do
      post :create, :invitation => { :email => 'another@test.com' }, :survey_id => surveys(:invitation).id
    end

    assert_redirected_to survey_invitation_path(surveys(:invitation), assigns(:invitation))
  end

  def test_should_show_invitation
    login_as :quentin
    get :show, :id => invitations(:one).id, :survey_id => surveys(:invitation).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :quentin
    get :edit, :id => invitations(:one).id, :survey_id => surveys(:invitation).id
    assert_response :success
  end

  def test_should_update_invitation
    login_as :quentin
    put :update, :id => invitations(:one).id, :invitation => { :email => 'test2@test.com' }, :survey_id => surveys(:invitation).id
    assert_redirected_to survey_invitation_path(surveys(:invitation), assigns(:invitation))
  end

  def test_should_destroy_invitation
    login_as :quentin
    assert_difference('Invitation.count', -1) do
      delete :destroy, :id => invitations(:one).id, :survey_id => surveys(:invitation).id
    end

    assert_redirected_to survey_invitations_path(surveys(:invitation))
  end
end
