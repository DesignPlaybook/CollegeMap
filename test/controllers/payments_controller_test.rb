require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create_order" do
    get payments_create_order_url
    assert_response :success
  end
end
