require File.dirname(__FILE__) + '/../test_helper'

class OptionTest < ActiveSupport::TestCase
  
  # Test option validation
  def test_option_should_require_label
    assert_no_difference 'Option.count' do
       o = Option.create()
       assert o.errors.on(:label)
     end
  end
  
  # Test acts as list
  def test_option_acts_as_list
    o = Option.create(:label => 'Test')
    assert_equal 1, o.position  
  end
 
end
