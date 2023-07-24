require "application_system_test_case"

class ViprReviewsTest < ApplicationSystemTestCase
  setup do
    @vipr_review = vipr_reviews(:one)
  end

  test "visiting the index" do
    visit vipr_reviews_url
    assert_selector "h1", text: "Vipr Reviews"
  end

  test "creating a Vipr review" do
    visit vipr_reviews_url
    click_on "New Vipr Review"

    fill_in "Email", with: @vipr_review.email
    fill_in "Name", with: @vipr_review.name
    fill_in "Order", with: @vipr_review.order
    fill_in "Plafond", with: @vipr_review.plafond
    fill_in "Title", with: @vipr_review.title
    click_on "Create Vipr review"

    assert_text "Vipr review was successfully created"
    click_on "Back"
  end

  test "updating a Vipr review" do
    visit vipr_reviews_url
    click_on "Edit", match: :first

    fill_in "Email", with: @vipr_review.email
    fill_in "Name", with: @vipr_review.name
    fill_in "Order", with: @vipr_review.order
    fill_in "Plafond", with: @vipr_review.plafond
    fill_in "Title", with: @vipr_review.title
    click_on "Update Vipr review"

    assert_text "Vipr review was successfully updated"
    click_on "Back"
  end

  test "destroying a Vipr review" do
    visit vipr_reviews_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vipr review was successfully destroyed"
  end
end
