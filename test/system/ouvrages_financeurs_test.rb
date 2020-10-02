require "application_system_test_case"

class OuvragesFinanceursTest < ApplicationSystemTestCase
  setup do
    @ouvrages_financeur = ouvrages_financeurs(:one)
  end

  test "visiting the index" do
    visit ouvrages_financeurs_url
    assert_selector "h1", text: "Ouvrages Financeurs"
  end

  test "creating a Ouvrages financeur" do
    visit ouvrages_financeurs_url
    click_on "New Ouvrages Financeur"

    fill_in "Financement actuel", with: @ouvrages_financeur.financement_actuel
    fill_in "Financement prevu", with: @ouvrages_financeur.financement_prevu
    fill_in "Name", with: @ouvrages_financeur.name
    fill_in "Ouvrage", with: @ouvrages_financeur.ouvrage_id
    click_on "Create Ouvrages financeur"

    assert_text "Ouvrages financeur was successfully created"
    click_on "Back"
  end

  test "updating a Ouvrages financeur" do
    visit ouvrages_financeurs_url
    click_on "Edit", match: :first

    fill_in "Financement actuel", with: @ouvrages_financeur.financement_actuel
    fill_in "Financement prevu", with: @ouvrages_financeur.financement_prevu
    fill_in "Name", with: @ouvrages_financeur.name
    fill_in "Ouvrage", with: @ouvrages_financeur.ouvrage_id
    click_on "Update Ouvrages financeur"

    assert_text "Ouvrages financeur was successfully updated"
    click_on "Back"
  end

  test "destroying a Ouvrages financeur" do
    visit ouvrages_financeurs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ouvrages financeur was successfully destroyed"
  end
end
