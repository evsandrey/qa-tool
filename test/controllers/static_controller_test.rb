require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get static_index_url
    assert_response :success
  end

  test "should get faq" do
    get static_faq_url
    assert_response :success
  end

  test "should get reports" do
    get static_reports_url
    assert_response :success
  end

end
