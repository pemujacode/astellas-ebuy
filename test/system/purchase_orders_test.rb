require "application_system_test_case"

class PurchaseOrdersTest < ApplicationSystemTestCase
  setup do
    @purchase_order = purchase_orders(:one)
  end

  test "visiting the index" do
    visit purchase_orders_url
    assert_selector "h1", text: "Purchase Orders"
  end

  test "creating a Purchase order" do
    visit purchase_orders_url
    click_on "New Purchase Order"

    fill_in "Buyer", with: @purchase_order.buyer
    fill_in "Delivery date", with: @purchase_order.delivery_date
    fill_in "Grand total", with: @purchase_order.grand_total
    fill_in "No", with: @purchase_order.no
    fill_in "Po date", with: @purchase_order.po_date
    fill_in "Prepared by", with: @purchase_order.prepared_by
    fill_in "Reviewed by", with: @purchase_order.reviewed_by
    fill_in "Status", with: @purchase_order.status
    fill_in "Supplier", with: @purchase_order.supplier_id
    fill_in "Terms payment", with: @purchase_order.terms_payment
    fill_in "Total", with: @purchase_order.total
    fill_in "Vat", with: @purchase_order.vat
    click_on "Create Purchase order"

    assert_text "Purchase order was successfully created"
    click_on "Back"
  end

  test "updating a Purchase order" do
    visit purchase_orders_url
    click_on "Edit", match: :first

    fill_in "Buyer", with: @purchase_order.buyer
    fill_in "Delivery date", with: @purchase_order.delivery_date
    fill_in "Grand total", with: @purchase_order.grand_total
    fill_in "No", with: @purchase_order.no
    fill_in "Po date", with: @purchase_order.po_date
    fill_in "Prepared by", with: @purchase_order.prepared_by
    fill_in "Reviewed by", with: @purchase_order.reviewed_by
    fill_in "Status", with: @purchase_order.status
    fill_in "Supplier", with: @purchase_order.supplier_id
    fill_in "Terms payment", with: @purchase_order.terms_payment
    fill_in "Total", with: @purchase_order.total
    fill_in "Vat", with: @purchase_order.vat
    click_on "Update Purchase order"

    assert_text "Purchase order was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase order" do
    visit purchase_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase order was successfully destroyed"
  end
end
