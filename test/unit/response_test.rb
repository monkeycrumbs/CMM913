require File.dirname(__FILE__) + '/../test_helper'

class ResponseTest < ActiveSupport::TestCase
  
  def test_response_should_require_survey_id
   assert_no_difference 'Response.count' do
     r = Response.create()
     assert r.errors.on(:survey_id)
   end
  end
 
end
