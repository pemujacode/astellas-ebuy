require 'test_helper'

class ViprReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vipr_review = vipr_reviews(:one)
  end

  test "should get index" do
    get vipr_reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_vipr_review_url
    assert_response :success
  end

  test "should create vipr_review" do
    assert_difference('ViprReview.count') do
      post vipr_reviews_url, params: { vipr_review: { email: @vipr_review.email, name: @vipr_review.name, order: @vipr_review.order, plafond: @vipr_review.plafond, title: @vipr_review.title } }
    end

    assert_redirected_to vipr_review_url(ViprReview.last)
  end

  test "should show vipr_review" do
    get vipr_review_url(@vipr_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_vipr_review_url(@vipr_review)
    assert_response :success
  end

  test "should update vipr_review" do
    patch vipr_review_url(@vipr_review), params: { vipr_review: { email: @vipr_review.email, name: @vipr_review.name, order: @vipr_review.order, plafond: @vipr_review.plafond, title: @vipr_review.title } }
    assert_redirected_to vipr_review_url(@vipr_review)
  end

  test "should destroy vipr_review" do
    assert_difference('ViprReview.count', -1) do
      delete vipr_review_url(@vipr_review)
    end

    assert_redirected_to vipr_reviews_url
  end
end
