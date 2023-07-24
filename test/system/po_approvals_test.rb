require "application_system_test_case"

class PoApprovalsTest < ApplicationSystemTestCase
  setup do
    @po_approval = po_approvals(:one)
  end

  test "visiting the index" do
    visit po_approvals_url
    assert_selector "h1", text: "Po Approvals"
  end

  test "creating a Po approval" do
    visit po_approvals_url
    click_on "New Po Approval"

    fill_in "Apv1", with: @po_approval.apv1
    fill_in "Apv1 amount", with: @po_approval.apv1_amount
    fill_in "Apv2", with: @po_approval.apv2
    fill_in "Apv2 amount", with: @po_approval.apv2_amount
    fill_in "Apv3", with: @po_approval.apv3
    fill_in "Apv3 amount", with: @po_approval.apv3_amount
    check "Is active" if @po_approval.is_active
    fill_in "Requester", with: @po_approval.requester
    click_on "Create Po approval"

    assert_text "Po approval was successfully created"
    click_on "Back"
  end

  test "updating a Po approval" do
    visit po_approvals_url
    click_on "Edit", match: :first

    fill_in "Apv1", with: @po_approval.apv1
    fill_in "Apv1 amount", with: @po_approval.apv1_amount
    fill_in "Apv2", with: @po_approval.apv2
    fill_in "Apv2 amount", with: @po_approval.apv2_amount
    fill_in "Apv3", with: @po_approval.apv3
    fill_in "Apv3 amount", with: @po_approval.apv3_amount
    check "Is active" if @po_approval.is_active
    fill_in "Requester", with: @po_approval.requester
    click_on "Update Po approval"

    assert_text "Po approval was successfully updated"
    click_on "Back"
  end

  test "destroying a Po approval" do
    visit po_approvals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Po approval was successfully destroyed"
  end
end
