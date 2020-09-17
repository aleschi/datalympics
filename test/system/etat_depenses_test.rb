require "application_system_test_case"

class EtatDepensesTest < ApplicationSystemTestCase
  setup do
    @etat_depense = etat_depenses(:one)
  end

  test "visiting the index" do
    visit etat_depenses_url
    assert_selector "h1", text: "Etat Depenses"
  end

  test "creating a Etat depense" do
    visit etat_depenses_url
    click_on "New Etat Depense"

    fill_in "Ae conso", with: @etat_depense.ae_conso
    fill_in "Ae prevu", with: @etat_depense.ae_prevu
    fill_in "Beneficiaire", with: @etat_depense.beneficiaire
    fill_in "Categorie", with: @etat_depense.categorie
    fill_in "Cp conso", with: @etat_depense.cp_conso
    fill_in "Cp prevu", with: @etat_depense.cp_prevu
    fill_in "Date", with: @etat_depense.date
    fill_in "Titre", with: @etat_depense.titre
    click_on "Create Etat depense"

    assert_text "Etat depense was successfully created"
    click_on "Back"
  end

  test "updating a Etat depense" do
    visit etat_depenses_url
    click_on "Edit", match: :first

    fill_in "Ae conso", with: @etat_depense.ae_conso
    fill_in "Ae prevu", with: @etat_depense.ae_prevu
    fill_in "Beneficiaire", with: @etat_depense.beneficiaire
    fill_in "Categorie", with: @etat_depense.categorie
    fill_in "Cp conso", with: @etat_depense.cp_conso
    fill_in "Cp prevu", with: @etat_depense.cp_prevu
    fill_in "Date", with: @etat_depense.date
    fill_in "Titre", with: @etat_depense.titre
    click_on "Update Etat depense"

    assert_text "Etat depense was successfully updated"
    click_on "Back"
  end

  test "destroying a Etat depense" do
    visit etat_depenses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Etat depense was successfully destroyed"
  end
end
