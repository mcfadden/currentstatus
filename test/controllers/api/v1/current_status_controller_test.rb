class ApiV1CurrentStatusControllerTest < ActionController::TestCase
  
  def setup
    @controller = Api::V1::CurrentStatusController.new
  end
  
  test "should get index" do
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:current_status)
    assert_not_nil assigns(:recent_messages)
  end
  
  test "get index with text format" do
    get :index, format: :text
    assert_response :success
    assert_not_nil assigns(:current_status)
    assert_not_nil assigns(:recent_messages)
  end

  test "post should update status" do
    Status.update_current_status("up")
    assert_difference(['Status.count', 'Message.count']) do
      post :update, format: :json, status: "down", message: "Foo Bar"
      assert_response :success
      
      assert_equal false, Status.current_status.is_up
      assert_equal "Foo Bar", Message.last.content
      
      assert_not_nil assigns(:current_status)
      assert_not_nil assigns(:recent_messages)
    end

  end

  test "post with only status or message" do
    Status.update_current_status("up")
    assert_difference(['Message.count']) do
      post :update, format: :json, message: "Foo Bar"
      assert_response :success
      
      # Should not have updated the status, but it should have updated the message
      assert_equal true, Status.current_status.is_up
      assert_equal "Foo Bar", Message.last.content
      
      assert_not_nil assigns(:current_status)
      assert_not_nil assigns(:recent_messages)
    end

    content = Message.last.content
    assert_difference(['Status.count']) do
      post :update, format: :json, status: "down"
      assert_response :success
      
      # Should have updated the status, but not the message
      assert_equal false, Status.current_status.is_up
      assert_equal content, Message.last.content
      
      assert_not_nil assigns(:current_status)
      assert_not_nil assigns(:recent_messages)
    end
  end
  
  test "post invalid status values" do
    post :update, format: :json, status: "foobar"
    assert_response 400
    
    post :update, format: :json, status: ""
    assert_response 400
    
    post :update, format: :json, randomKey: "helloWorld"
    assert_response 400
    
    assert_not_nil assigns(:error)
  end
  
  test "post with really long message" do
    post :update, format: :json, message: ("Lorem ipsum dolor sit amet" * 50)
    assert_response :success
  end
  
  test "post with fun characters" do
    post :update, format: :json, message: "<blink>Hello Workd</blink>&amp;☺✌"
    assert_response :success
  end
  
end