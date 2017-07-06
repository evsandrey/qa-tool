require 'test_helper'

class MarkingRulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marking_rule = marking_rules(:one)
  end

  test "should get index" do
    get marking_rules_url
    assert_response :success
  end

  test "should get new" do
    get new_marking_rule_url
    assert_response :success
  end

  test "should create marking_rule" do
    assert_difference('MarkingRule.count') do
      post marking_rules_url, params: { marking_rule: { name: @marking_rule.name, pattern: @marking_rule.pattern } }
    end

    assert_redirected_to marking_rule_url(MarkingRule.last)
  end

  test "should show marking_rule" do
    get marking_rule_url(@marking_rule)
    assert_response :success
  end

  test "should get edit" do
    get edit_marking_rule_url(@marking_rule)
    assert_response :success
  end

  test "should update marking_rule" do
    patch marking_rule_url(@marking_rule), params: { marking_rule: { name: @marking_rule.name, pattern: @marking_rule.pattern } }
    assert_redirected_to marking_rule_url(@marking_rule)
  end

  test "should destroy marking_rule" do
    assert_difference('MarkingRule.count', -1) do
      delete marking_rule_url(@marking_rule)
    end

    assert_redirected_to marking_rules_url
  end
end
