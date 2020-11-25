require 'test_helper'

class ChantiersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chantier = chantiers(:one)
  end

  test "should get index" do
    get chantiers_url
    assert_response :success
  end

  test "should get new" do
    get new_chantier_url
    assert_response :success
  end

  test "should create chantier" do
    assert_difference('Chantier.count') do
      post chantiers_url, params: { chantier: { name: @chantier.name, ouvrage_id: @chantier.ouvrage_id } }
    end

    assert_redirected_to chantier_url(Chantier.last)
  end

  test "should show chantier" do
    get chantier_url(@chantier)
    assert_response :success
  end

  test "should get edit" do
    get edit_chantier_url(@chantier)
    assert_response :success
  end

  test "should update chantier" do
    patch chantier_url(@chantier), params: { chantier: { name: @chantier.name, ouvrage_id: @chantier.ouvrage_id } }
    assert_redirected_to chantier_url(@chantier)
  end

  test "should destroy chantier" do
    assert_difference('Chantier.count', -1) do
      delete chantier_url(@chantier)
    end

    assert_redirected_to chantiers_url
  end
end
