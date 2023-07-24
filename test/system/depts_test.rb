require "application_system_test_case"

class DeptsTest < ApplicationSystemTestCase
  setup do
    @dept = depts(:one)
  end

  test "visiting the index" do
    visit depts_url
    assert_selector "h1", text: "Depts"
  end

  test "creating a Dept" do
    visit depts_url
    click_on "New Dept"

    fill_in "Code", with: @dept.code
    fill_in "Name", with: @dept.name
    click_on "Create Dept"

    assert_text "Dept was successfully created"
    click_on "Back"
  end

  test "updating a Dept" do
    visit depts_url
    click_on "Edit", match: :first

    fill_in "Code", with: @dept.code
    fill_in "Name", with: @dept.name
    click_on "Update Dept"

    assert_text "Dept was successfully updated"
    click_on "Back"
  end

  test "destroying a Dept" do
    visit depts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dept was successfully destroyed"
  end
end
