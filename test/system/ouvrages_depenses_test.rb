require "application_system_test_case"

class OuvragesDepensesTest < ApplicationSystemTestCase
  setup do
    @ouvrages_depense = ouvrages_depenses(:one)
  end

  test "visiting the index" do
    visit ouvrages_depenses_url
    assert_selector "h1", text: "Ouvrages Depenses"
  end

  test "creating a Ouvrages depense" do
    visit ouvrages_depenses_url
    click_on "New Ouvrages Depense"

    fill_in "Date", with: @ouvrages_depense.date
    fill_in "Montant", with: @ouvrages_depense.montant
    fill_in "Name", with: @ouvrages_depense.name
    fill_in "Ouvrage", with: @ouvrages_depense.ouvrage_id
    click_on "Create Ouvrages depense"

    assert_text "Ouvrages depense was successfully created"
    click_on "Back"
  end

  test "updating a Ouvrages depense" do
    visit ouvrages_depenses_url
    click_on "Edit", match: :first

    fill_in "Date", with: @ouvrages_depense.date
    fill_in "Montant", with: @ouvrages_depense.montant
    fill_in "Name", with: @ouvrages_depense.name
    fill_in "Ouvrage", with: @ouvrages_depense.ouvrage_id
    click_on "Update Ouvrages depense"

    assert_text "Ouvrages depense was successfully updated"
    click_on "Back"
  end

  test "destroying a Ouvrages depense" do
    visit ouvrages_depenses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ouvrages depense was successfully destroyed"
  end
end
