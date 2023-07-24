require "application_system_test_case"

class PrApprovalsTest < ApplicationSystemTestCase
  setup do
    @pr_approval = pr_approvals(:one)
  end

  test "visiting the index" do
    visit pr_approvals_url
    assert_selector "h1", text: "Pr Approvals"
  end

  test "creating a Pr approval" do
    visit pr_approvals_url
    click_on "New Pr Approval"

    fill_in "Apv1", with: @pr_approval.apv1
    fill_in "Apv1 amount", with: @pr_approval.apv1_amount
    fill_in "Apv2", with: @pr_approval.apv2
    fill_in "Apv2 amount", with: @pr_approval.apv2_amount
    fill_in "Apv3", with: @pr_approval.apv3
    fill_in "Apv3 amount", with: @pr_approval.apv3_amount
    fill_in "Apv4", with: @pr_approval.apv4
    fill_in "Apv4 amount", with: @pr_approval.apv4_amount
    check "Is active" if @pr_approval.is_active
    fill_in "Requester", with: @pr_approval.requester
    click_on "Create Pr approval"

    assert_text "Pr approval was successfully created"
    click_on "Back"
  end

  test "updating a Pr approval" do
    visit pr_approvals_url
    click_on "Edit", match: :first

    fill_in "Apv1", with: @pr_approval.apv1
    fill_in "Apv1 amount", with: @pr_approval.apv1_amount
    fill_in "Apv2", with: @pr_approval.apv2
    fill_in "Apv2 amount", with: @pr_approval.apv2_amount
    fill_in "Apv3", with: @pr_approval.apv3
    fill_in "Apv3 amount", with: @pr_approval.apv3_amount
    fill_in "Apv4", with: @pr_approval.apv4
    fill_in "Apv4 amount", with: @pr_approval.apv4_amount
    check "Is active" if @pr_approval.is_active
    fill_in "Requester", with: @pr_approval.requester
    click_on "Update Pr approval"

    assert_text "Pr approval was successfully updated"
    click_on "Back"
  end

  test "destroying a Pr approval" do
    visit pr_approvals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pr approval was successfully destroyed"
  end
end
