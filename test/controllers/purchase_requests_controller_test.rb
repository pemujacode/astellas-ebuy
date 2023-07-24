require 'test_helper'

class PurchaseRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase_request = purchase_requests(:one)
  end

  test "should get index" do
    get purchase_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_request_url
    assert_response :success
  end

  test "should create purchase_request" do
    assert_difference('PurchaseRequest.count') do
      post purchase_requests_url, params: { purchase_request: { no: @purchase_request.no, notes: @purchase_request.notes, request_date: @purchase_request.request_date, requester: @purchase_request.requester, required_date: @purchase_request.required_date, user_id: @purchase_request.user_id } }
    end

    assert_redirected_to purchase_request_url(PurchaseRequest.last)
  end

  test "should show purchase_request" do
    get purchase_request_url(@purchase_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_request_url(@purchase_request)
    assert_response :success
  end

  test "should update purchase_request" do
    patch purchase_request_url(@purchase_request), params: { purchase_request: { no: @purchase_request.no, notes: @purchase_request.notes, request_date: @purchase_request.request_date, requester: @purchase_request.requester, required_date: @purchase_request.required_date, user_id: @purchase_request.user_id } }
    assert_redirected_to purchase_request_url(@purchase_request)
  end

  test "should destroy purchase_request" do
    assert_difference('PurchaseRequest.count', -1) do
      delete purchase_request_url(@purchase_request)
    end

    assert_redirected_to purchase_requests_url
  end
end
