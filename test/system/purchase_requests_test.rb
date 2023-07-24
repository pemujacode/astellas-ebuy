require "application_system_test_case"

class PurchaseRequestsTest < ApplicationSystemTestCase
  setup do
    @purchase_request = purchase_requests(:one)
  end

  test "visiting the index" do
    visit purchase_requests_url
    assert_selector "h1", text: "Purchase Requests"
  end

  test "creating a Purchase request" do
    visit purchase_requests_url
    click_on "New Purchase Request"

    fill_in "No", with: @purchase_request.no
    fill_in "Notes", with: @purchase_request.notes
    fill_in "Request date", with: @purchase_request.request_date
    fill_in "Requester", with: @purchase_request.requester
    fill_in "Required date", with: @purchase_request.required_date
    fill_in "User", with: @purchase_request.user_id
    click_on "Create Purchase request"

    assert_text "Purchase request was successfully created"
    click_on "Back"
  end

  test "updating a Purchase request" do
    visit purchase_requests_url
    click_on "Edit", match: :first

    fill_in "No", with: @purchase_request.no
    fill_in "Notes", with: @purchase_request.notes
    fill_in "Request date", with: @purchase_request.request_date
    fill_in "Requester", with: @purchase_request.requester
    fill_in "Required date", with: @purchase_request.required_date
    fill_in "User", with: @purchase_request.user_id
    click_on "Update Purchase request"

    assert_text "Purchase request was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase request" do
    visit purchase_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase request was successfully destroyed"
  end
end
