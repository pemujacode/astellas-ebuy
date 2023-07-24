require 'test_helper'

class DeptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dept = depts(:one)
  end

  test "should get index" do
    get depts_url
    assert_response :success
  end

  test "should get new" do
    get new_dept_url
    assert_response :success
  end

  test "should create dept" do
    assert_difference('Dept.count') do
      post depts_url, params: { dept: { code: @dept.code, name: @dept.name } }
    end

    assert_redirected_to dept_url(Dept.last)
  end

  test "should show dept" do
    get dept_url(@dept)
    assert_response :success
  end

  test "should get edit" do
    get edit_dept_url(@dept)
    assert_response :success
  end

  test "should update dept" do
    patch dept_url(@dept), params: { dept: { code: @dept.code, name: @dept.name } }
    assert_redirected_to dept_url(@dept)
  end

  test "should destroy dept" do
    assert_difference('Dept.count', -1) do
      delete dept_url(@dept)
    end

    assert_redirected_to depts_url
  end
end
