class StatusControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:current_status)
    assert_not_nil assigns(:recent_messages)
  end

  test "post should update status" do
    get :index, status: "down", message: "Foo Bar"
    assert_response :success
    assert_not_nil assigns(:current_status)
    assert_not_nil assigns(:recent_messages)
    
    assert_true # Actually updates the status
  end

  test "post with status or message key but no value" do
    assert_true
  end
  
  test "post invalid status values" do
    assert_true
  end
  
  test "post with really long message" do
    assert_true
  end
  
  test "post with fun characters" do
    assert_true
  end

end