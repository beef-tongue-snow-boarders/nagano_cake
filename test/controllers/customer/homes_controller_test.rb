require "test_helper"

class Customer::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get customer_homes_top_url
    assert_response :success
  end

  test "should get about" do
    get customer_homes_about_url
    assert_response :success
  end
end
