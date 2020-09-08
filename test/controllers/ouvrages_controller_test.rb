require 'test_helper'

class OuvragesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ouvrage = ouvrages(:one)
  end

  test "should get index" do
    get ouvrages_url
    assert_response :success
  end

  test "should get new" do
    get new_ouvrage_url
    assert_response :success
  end

  test "should create ouvrage" do
    assert_difference('Ouvrage.count') do
      post ouvrages_url, params: { ouvrage: { name: @ouvrage.name } }
    end

    assert_redirected_to ouvrage_url(Ouvrage.last)
  end

  test "should show ouvrage" do
    get ouvrage_url(@ouvrage)
    assert_response :success
  end

  test "should get edit" do
    get edit_ouvrage_url(@ouvrage)
    assert_response :success
  end

  test "should update ouvrage" do
    patch ouvrage_url(@ouvrage), params: { ouvrage: { name: @ouvrage.name } }
    assert_redirected_to ouvrage_url(@ouvrage)
  end

  test "should destroy ouvrage" do
    assert_difference('Ouvrage.count', -1) do
      delete ouvrage_url(@ouvrage)
    end

    assert_redirected_to ouvrages_url
  end
end
