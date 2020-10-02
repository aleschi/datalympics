require 'test_helper'

class OuvragesFinancementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ouvrages_financement = ouvrages_financements(:one)
  end

  test "should get index" do
    get ouvrages_financements_url
    assert_response :success
  end

  test "should get new" do
    get new_ouvrages_financement_url
    assert_response :success
  end

  test "should create ouvrages_financement" do
    assert_difference('OuvragesFinancement.count') do
      post ouvrages_financements_url, params: { ouvrages_financement: { date: @ouvrages_financement.date, montant: @ouvrages_financement.montant, name: @ouvrages_financement.name, ouvrage_id: @ouvrages_financement.ouvrage_id } }
    end

    assert_redirected_to ouvrages_financement_url(OuvragesFinancement.last)
  end

  test "should show ouvrages_financement" do
    get ouvrages_financement_url(@ouvrages_financement)
    assert_response :success
  end

  test "should get edit" do
    get edit_ouvrages_financement_url(@ouvrages_financement)
    assert_response :success
  end

  test "should update ouvrages_financement" do
    patch ouvrages_financement_url(@ouvrages_financement), params: { ouvrages_financement: { date: @ouvrages_financement.date, montant: @ouvrages_financement.montant, name: @ouvrages_financement.name, ouvrage_id: @ouvrages_financement.ouvrage_id } }
    assert_redirected_to ouvrages_financement_url(@ouvrages_financement)
  end

  test "should destroy ouvrages_financement" do
    assert_difference('OuvragesFinancement.count', -1) do
      delete ouvrages_financement_url(@ouvrages_financement)
    end

    assert_redirected_to ouvrages_financements_url
  end
end
