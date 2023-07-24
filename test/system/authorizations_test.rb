require "application_system_test_case"

class AuthorizationsTest < ApplicationSystemTestCase
  setup do
    @authorization = authorizations(:one)
  end

  test "visiting the index" do
    visit authorizations_url
    assert_selector "h1", text: "Authorizations"
  end

  test "creating a Authorization" do
    visit authorizations_url
    click_on "New Authorization"

    fill_in "Costcenter", with: @authorization.costcenter
    fill_in "Currency", with: @authorization.currency
    fill_in "Department", with: @authorization.department
    fill_in "Expense", with: @authorization.expense
    fill_in "P grn", with: @authorization.p_grn
    fill_in "P order", with: @authorization.p_order
    fill_in "P request", with: @authorization.p_request
    fill_in "Supplier", with: @authorization.supplier
    fill_in "User", with: @authorization.user_id
    click_on "Create Authorization"

    assert_text "Authorization was successfully created"
    click_on "Back"
  end

  test "updating a Authorization" do
    visit authorizations_url
    click_on "Edit", match: :first

    fill_in "Costcenter", with: @authorization.costcenter
    fill_in "Currency", with: @authorization.currency
    fill_in "Department", with: @authorization.department
    fill_in "Expense", with: @authorization.expense
    fill_in "P grn", with: @authorization.p_grn
    fill_in "P order", with: @authorization.p_order
    fill_in "P request", with: @authorization.p_request
    fill_in "Supplier", with: @authorization.supplier
    fill_in "User", with: @authorization.user_id
    click_on "Update Authorization"

    assert_text "Authorization was successfully updated"
    click_on "Back"
  end

  test "destroying a Authorization" do
    visit authorizations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Authorization was successfully destroyed"
  end
end
