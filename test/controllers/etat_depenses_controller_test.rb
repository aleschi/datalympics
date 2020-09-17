require 'test_helper'

class EtatDepensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @etat_depense = etat_depenses(:one)
  end

  test "should get index" do
    get etat_depenses_url
    assert_response :success
  end

  test "should get new" do
    get new_etat_depense_url
    assert_response :success
  end

  test "should create etat_depense" do
    assert_difference('EtatDepense.count') do
      post etat_depenses_url, params: { etat_depense: { ae_conso: @etat_depense.ae_conso, ae_prevu: @etat_depense.ae_prevu, beneficiaire: @etat_depense.beneficiaire, categorie: @etat_depense.categorie, cp_conso: @etat_depense.cp_conso, cp_prevu: @etat_depense.cp_prevu, date: @etat_depense.date, titre: @etat_depense.titre } }
    end

    assert_redirected_to etat_depense_url(EtatDepense.last)
  end

  test "should show etat_depense" do
    get etat_depense_url(@etat_depense)
    assert_response :success
  end

  test "should get edit" do
    get edit_etat_depense_url(@etat_depense)
    assert_response :success
  end

  test "should update etat_depense" do
    patch etat_depense_url(@etat_depense), params: { etat_depense: { ae_conso: @etat_depense.ae_conso, ae_prevu: @etat_depense.ae_prevu, beneficiaire: @etat_depense.beneficiaire, categorie: @etat_depense.categorie, cp_conso: @etat_depense.cp_conso, cp_prevu: @etat_depense.cp_prevu, date: @etat_depense.date, titre: @etat_depense.titre } }
    assert_redirected_to etat_depense_url(@etat_depense)
  end

  test "should destroy etat_depense" do
    assert_difference('EtatDepense.count', -1) do
      delete etat_depense_url(@etat_depense)
    end

    assert_redirected_to etat_depenses_url
  end
end
