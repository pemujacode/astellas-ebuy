require "application_system_test_case"

class ExpensesTest < ApplicationSystemTestCase
  setup do
    @expense_ = expense_s(:one)
  end

  test "visiting the index" do
    visit expense_s_url
    assert_selector "h1", text: "Expenses"
  end

  test "creating a Expense s" do
    visit expense_s_url
    click_on "New Expense S"

    click_on "Create Expense s"

    assert_text "Expense s was successfully created"
    click_on "Back"
  end

  test "updating a Expense s" do
    visit expense_s_url
    click_on "Edit", match: :first

    click_on "Update Expense s"

    assert_text "Expense s was successfully updated"
    click_on "Back"
  end

  test "destroying a Expense s" do
    visit expense_s_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Expense s was successfully destroyed"
  end
end
