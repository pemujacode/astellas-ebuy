require 'test_helper'

class ViprsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vipr = viprs(:one)
  end

  test "should get index" do
    get viprs_url
    assert_response :success
  end

  test "should get new" do
    get new_vipr_url
    assert_response :success
  end

  test "should create vipr" do
    assert_difference('Vipr.count') do
      post viprs_url, params: { vipr: { approval1: @vipr.approval1, approval2: @vipr.approval2, approval3: @vipr.approval3, approval4: @vipr.approval4, apv_date1: @vipr.apv_date1, apv_date2: @vipr.apv_date2, apv_date3: @vipr.apv_date3, apv_date4: @vipr.apv_date4, currency: @vipr.currency, due_date: @vipr.due_date, invoice_date: @vipr.invoice_date, invoice_no: @vipr.invoice_no, payment_no: @vipr.payment_no, remarks: @vipr.remarks, requester: @vipr.requester } }
    end

    assert_redirected_to vipr_url(Vipr.last)
  end

  test "should show vipr" do
    get vipr_url(@vipr)
    assert_response :success
  end

  test "should get edit" do
    get edit_vipr_url(@vipr)
    assert_response :success
  end

  test "should update vipr" do
    patch vipr_url(@vipr), params: { vipr: { approval1: @vipr.approval1, approval2: @vipr.approval2, approval3: @vipr.approval3, approval4: @vipr.approval4, apv_date1: @vipr.apv_date1, apv_date2: @vipr.apv_date2, apv_date3: @vipr.apv_date3, apv_date4: @vipr.apv_date4, currency: @vipr.currency, due_date: @vipr.due_date, invoice_date: @vipr.invoice_date, invoice_no: @vipr.invoice_no, payment_no: @vipr.payment_no, remarks: @vipr.remarks, requester: @vipr.requester } }
    assert_redirected_to vipr_url(@vipr)
  end

  test "should destroy vipr" do
    assert_difference('Vipr.count', -1) do
      delete vipr_url(@vipr)
    end

    assert_redirected_to viprs_url
  end
end
