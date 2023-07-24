require 'test_helper'

class PrApprovalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pr_approval = pr_approvals(:one)
  end

  test "should get index" do
    get pr_approvals_url
    assert_response :success
  end

  test "should get new" do
    get new_pr_approval_url
    assert_response :success
  end

  test "should create pr_approval" do
    assert_difference('PrApproval.count') do
      post pr_approvals_url, params: { pr_approval: { apv1: @pr_approval.apv1, apv1_amount: @pr_approval.apv1_amount, apv2: @pr_approval.apv2, apv2_amount: @pr_approval.apv2_amount, apv3: @pr_approval.apv3, apv3_amount: @pr_approval.apv3_amount, apv4: @pr_approval.apv4, apv4_amount: @pr_approval.apv4_amount, is_active: @pr_approval.is_active, requester: @pr_approval.requester } }
    end

    assert_redirected_to pr_approval_url(PrApproval.last)
  end

  test "should show pr_approval" do
    get pr_approval_url(@pr_approval)
    assert_response :success
  end

  test "should get edit" do
    get edit_pr_approval_url(@pr_approval)
    assert_response :success
  end

  test "should update pr_approval" do
    patch pr_approval_url(@pr_approval), params: { pr_approval: { apv1: @pr_approval.apv1, apv1_amount: @pr_approval.apv1_amount, apv2: @pr_approval.apv2, apv2_amount: @pr_approval.apv2_amount, apv3: @pr_approval.apv3, apv3_amount: @pr_approval.apv3_amount, apv4: @pr_approval.apv4, apv4_amount: @pr_approval.apv4_amount, is_active: @pr_approval.is_active, requester: @pr_approval.requester } }
    assert_redirected_to pr_approval_url(@pr_approval)
  end

  test "should destroy pr_approval" do
    assert_difference('PrApproval.count', -1) do
      delete pr_approval_url(@pr_approval)
    end

    assert_redirected_to pr_approvals_url
  end
end
