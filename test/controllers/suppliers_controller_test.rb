require 'test_helper'

class SuppliersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplier = suppliers(:one)
  end

  test "should get index" do
    get suppliers_url
    assert_response :success
  end

  test "should get new" do
    get new_supplier_url
    assert_response :success
  end

  test "should create supplier" do
    assert_difference('Supplier.count') do
      post suppliers_url, params: { supplier: { address: @supplier.address, code: @supplier.code, currency_id: @supplier.currency_id, email: @supplier.email, name: @supplier.name, npwp: @supplier.npwp, phone: @supplier.phone, pic: @supplier.pic, printing_name: @supplier.printing_name } }
    end

    assert_redirected_to supplier_url(Supplier.last)
  end

  test "should show supplier" do
    get supplier_url(@supplier)
    assert_response :success
  end

  test "should get edit" do
    get edit_supplier_url(@supplier)
    assert_response :success
  end

  test "should update supplier" do
    patch supplier_url(@supplier), params: { supplier: { address: @supplier.address, code: @supplier.code, currency_id: @supplier.currency_id, email: @supplier.email, name: @supplier.name, npwp: @supplier.npwp, phone: @supplier.phone, pic: @supplier.pic, printing_name: @supplier.printing_name } }
    assert_redirected_to supplier_url(@supplier)
  end

  test "should destroy supplier" do
    assert_difference('Supplier.count', -1) do
      delete supplier_url(@supplier)
    end

    assert_redirected_to suppliers_url
  end
end
