class CurrentStatusControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:current_status)
    assert_not_nil assigns(:recent_messages)
  end
end