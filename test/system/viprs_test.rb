require "application_system_test_case"

class ViprsTest < ApplicationSystemTestCase
  setup do
    @vipr = viprs(:one)
  end

  test "visiting the index" do
    visit viprs_url
    assert_selector "h1", text: "Viprs"
  end

  test "creating a Vipr" do
    visit viprs_url
    click_on "New Vipr"

    fill_in "Approval1", with: @vipr.approval1
    fill_in "Approval2", with: @vipr.approval2
    fill_in "Approval3", with: @vipr.approval3
    fill_in "Approval4", with: @vipr.approval4
    fill_in "Apv date1", with: @vipr.apv_date1
    fill_in "Apv date2", with: @vipr.apv_date2
    fill_in "Apv date3", with: @vipr.apv_date3
    fill_in "Apv date4", with: @vipr.apv_date4
    fill_in "Currency", with: @vipr.currency
    fill_in "Due date", with: @vipr.due_date
    fill_in "Invoice date", with: @vipr.invoice_date
    fill_in "Invoice no", with: @vipr.invoice_no
    fill_in "Payment no", with: @vipr.payment_no
    fill_in "Remarks", with: @vipr.remarks
    fill_in "Requester", with: @vipr.requester
    click_on "Create Vipr"

    assert_text "Vipr was successfully created"
    click_on "Back"
  end

  test "updating a Vipr" do
    visit viprs_url
    click_on "Edit", match: :first

    fill_in "Approval1", with: @vipr.approval1
    fill_in "Approval2", with: @vipr.approval2
    fill_in "Approval3", with: @vipr.approval3
    fill_in "Approval4", with: @vipr.approval4
    fill_in "Apv date1", with: @vipr.apv_date1
    fill_in "Apv date2", with: @vipr.apv_date2
    fill_in "Apv date3", with: @vipr.apv_date3
    fill_in "Apv date4", with: @vipr.apv_date4
    fill_in "Currency", with: @vipr.currency
    fill_in "Due date", with: @vipr.due_date
    fill_in "Invoice date", with: @vipr.invoice_date
    fill_in "Invoice no", with: @vipr.invoice_no
    fill_in "Payment no", with: @vipr.payment_no
    fill_in "Remarks", with: @vipr.remarks
    fill_in "Requester", with: @vipr.requester
    click_on "Update Vipr"

    assert_text "Vipr was successfully updated"
    click_on "Back"
  end

  test "destroying a Vipr" do
    visit viprs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vipr was successfully destroyed"
  end
end
