require 'test_helper'

class PoApprovalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @po_approval = po_approvals(:one)
  end

  test "should get index" do
    get po_approvals_url
    assert_response :success
  end

  test "should get new" do
    get new_po_approval_url
    assert_response :success
  end

  test "should create po_approval" do
    assert_difference('PoApproval.count') do
      post po_approvals_url, params: { po_approval: { apv1: @po_approval.apv1, apv1_amount: @po_approval.apv1_amount, apv2: @po_approval.apv2, apv2_amount: @po_approval.apv2_amount, apv3: @po_approval.apv3, apv3_amount: @po_approval.apv3_amount, is_active: @po_approval.is_active, requester: @po_approval.requester } }
    end

    assert_redirected_to po_approval_url(PoApproval.last)
  end

  test "should show po_approval" do
    get po_approval_url(@po_approval)
    assert_response :success
  end

  test "should get edit" do
    get edit_po_approval_url(@po_approval)
    assert_response :success
  end

  test "should update po_approval" do
    patch po_approval_url(@po_approval), params: { po_approval: { apv1: @po_approval.apv1, apv1_amount: @po_approval.apv1_amount, apv2: @po_approval.apv2, apv2_amount: @po_approval.apv2_amount, apv3: @po_approval.apv3, apv3_amount: @po_approval.apv3_amount, is_active: @po_approval.is_active, requester: @po_approval.requester } }
    assert_redirected_to po_approval_url(@po_approval)
  end

  test "should destroy po_approval" do
    assert_difference('PoApproval.count', -1) do
      delete po_approval_url(@po_approval)
    end

    assert_redirected_to po_approvals_url
  end
end
