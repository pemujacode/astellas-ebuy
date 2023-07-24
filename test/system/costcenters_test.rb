require "application_system_test_case"

class CostcentersTest < ApplicationSystemTestCase
  setup do
    @costcenter = costcenters(:one)
  end

  test "visiting the index" do
    visit costcenters_url
    assert_selector "h1", text: "Costcenters"
  end

  test "creating a Costcenter" do
    visit costcenters_url
    click_on "New Costcenter"

    fill_in "Code", with: @costcenter.code
    fill_in "Name", with: @costcenter.name
    click_on "Create Costcenter"

    assert_text "Costcenter was successfully created"
    click_on "Back"
  end

  test "updating a Costcenter" do
    visit costcenters_url
    click_on "Edit", match: :first

    fill_in "Code", with: @costcenter.code
    fill_in "Name", with: @costcenter.name
    click_on "Update Costcenter"

    assert_text "Costcenter was successfully updated"
    click_on "Back"
  end

  test "destroying a Costcenter" do
    visit costcenters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Costcenter was successfully destroyed"
  end
end
