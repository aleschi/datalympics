require 'test_helper'

class OuvragesFinanceursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ouvrages_financeur = ouvrages_financeurs(:one)
  end

  test "should get index" do
    get ouvrages_financeurs_url
    assert_response :success
  end

  test "should get new" do
    get new_ouvrages_financeur_url
    assert_response :success
  end

  test "should create ouvrages_financeur" do
    assert_difference('OuvragesFinanceur.count') do
      post ouvrages_financeurs_url, params: { ouvrages_financeur: { financement_actuel: @ouvrages_financeur.financement_actuel, financement_prevu: @ouvrages_financeur.financement_prevu, name: @ouvrages_financeur.name, ouvrage_id: @ouvrages_financeur.ouvrage_id } }
    end

    assert_redirected_to ouvrages_financeur_url(OuvragesFinanceur.last)
  end

  test "should show ouvrages_financeur" do
    get ouvrages_financeur_url(@ouvrages_financeur)
    assert_response :success
  end

  test "should get edit" do
    get edit_ouvrages_financeur_url(@ouvrages_financeur)
    assert_response :success
  end

  test "should update ouvrages_financeur" do
    patch ouvrages_financeur_url(@ouvrages_financeur), params: { ouvrages_financeur: { financement_actuel: @ouvrages_financeur.financement_actuel, financement_prevu: @ouvrages_financeur.financement_prevu, name: @ouvrages_financeur.name, ouvrage_id: @ouvrages_financeur.ouvrage_id } }
    assert_redirected_to ouvrages_financeur_url(@ouvrages_financeur)
  end

  test "should destroy ouvrages_financeur" do
    assert_difference('OuvragesFinanceur.count', -1) do
      delete ouvrages_financeur_url(@ouvrages_financeur)
    end

    assert_redirected_to ouvrages_financeurs_url
  end
end
