require 'test_helper'

class InvestigationResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @investigation_result = investigation_results(:one)
  end

  test "should get index" do
    get investigation_results_url
    assert_response :success
  end

  test "should get new" do
    get new_investigation_result_url
    assert_response :success
  end

  test "should create investigation_result" do
    assert_difference('InvestigationResult.count') do
      post investigation_results_url, params: { investigation_result: { code: @investigation_result.code, description: @investigation_result.description, name: @investigation_result.name } }
    end

    assert_redirected_to investigation_result_url(InvestigationResult.last)
  end

  test "should show investigation_result" do
    get investigation_result_url(@investigation_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_investigation_result_url(@investigation_result)
    assert_response :success
  end

  test "should update investigation_result" do
    patch investigation_result_url(@investigation_result), params: { investigation_result: { code: @investigation_result.code, description: @investigation_result.description, name: @investigation_result.name } }
    assert_redirected_to investigation_result_url(@investigation_result)
  end

  test "should destroy investigation_result" do
    assert_difference('InvestigationResult.count', -1) do
      delete investigation_result_url(@investigation_result)
    end

    assert_redirected_to investigation_results_url
  end
end
