require 'test_helper'

class CostcentersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @costcenter = costcenters(:one)
  end

  test "should get index" do
    get costcenters_url
    assert_response :success
  end

  test "should get new" do
    get new_costcenter_url
    assert_response :success
  end

  test "should create costcenter" do
    assert_difference('Costcenter.count') do
      post costcenters_url, params: { costcenter: { code: @costcenter.code, name: @costcenter.name } }
    end

    assert_redirected_to costcenter_url(Costcenter.last)
  end

  test "should show costcenter" do
    get costcenter_url(@costcenter)
    assert_response :success
  end

  test "should get edit" do
    get edit_costcenter_url(@costcenter)
    assert_response :success
  end

  test "should update costcenter" do
    patch costcenter_url(@costcenter), params: { costcenter: { code: @costcenter.code, name: @costcenter.name } }
    assert_redirected_to costcenter_url(@costcenter)
  end

  test "should destroy costcenter" do
    assert_difference('Costcenter.count', -1) do
      delete costcenter_url(@costcenter)
    end

    assert_redirected_to costcenters_url
  end
end
