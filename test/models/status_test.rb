require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "should require is_up value" do
    status = Status.new
    assert_not status.save
    
    status.is_up = false
    assert status.save
  end
  
  test "current status" do
    new_status = Status.create(is_up: true)
    assert_equal new_status, Status.current_status
  end
  
  test "updating status to the current value" do
    assert_true
  end
end
