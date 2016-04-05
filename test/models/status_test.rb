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

  test "update_current_status" do
    assert_equal false, Status.update_current_status("true")
    assert_equal false, Status.update_current_status("foobar")
    assert_equal false, Status.update_current_status(nil)
    assert_equal false, Status.update_current_status("")
    
    assert_kind_of Status, Status.update_current_status("up")
    assert_kind_of Status, Status.update_current_status("UP")
    assert_kind_of Status, Status.update_current_status("DOWN")
    assert_kind_of Status, Status.update_current_status("DoWn")
    assert_kind_of Status, Status.update_current_status(false)
    assert_kind_of Status, Status.update_current_status(true)
  end
  
  test "updating status to the current value" do
    # Updating the status to the current value should do nothing.
    assert_no_difference("Status.count") do
      Status.update_current_status(Status.current_status.is_up)
    end
  end
end
