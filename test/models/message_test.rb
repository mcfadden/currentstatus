require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "should require content" do
    message = Message.new
    assert_not message.save
    
    message.content = "Lorem ipsum dolor sit amet"
    assert message.save
  end
  
  test "recent messages" do
    assert_true
  end
end
