require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "should require is_up value" do
    status = Status.new
    assert_not status.save
    
    status.is_up = false
    assert status.save
  end
end
