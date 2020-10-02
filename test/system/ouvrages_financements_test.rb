require "application_system_test_case"

class OuvragesFinancementsTest < ApplicationSystemTestCase
  setup do
    @ouvrages_financement = ouvrages_financements(:one)
  end

  test "visiting the index" do
    visit ouvrages_financements_url
    assert_selector "h1", text: "Ouvrages Financements"
  end

  test "creating a Ouvrages financement" do
    visit ouvrages_financements_url
    click_on "New Ouvrages Financement"

    fill_in "Date", with: @ouvrages_financement.date
    fill_in "Montant", with: @ouvrages_financement.montant
    fill_in "Name", with: @ouvrages_financement.name
    fill_in "Ouvrage", with: @ouvrages_financement.ouvrage_id
    click_on "Create Ouvrages financement"

    assert_text "Ouvrages financement was successfully created"
    click_on "Back"
  end

  test "updating a Ouvrages financement" do
    visit ouvrages_financements_url
    click_on "Edit", match: :first

    fill_in "Date", with: @ouvrages_financement.date
    fill_in "Montant", with: @ouvrages_financement.montant
    fill_in "Name", with: @ouvrages_financement.name
    fill_in "Ouvrage", with: @ouvrages_financement.ouvrage_id
    click_on "Update Ouvrages financement"

    assert_text "Ouvrages financement was successfully updated"
    click_on "Back"
  end

  test "destroying a Ouvrages financement" do
    visit ouvrages_financements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ouvrages financement was successfully destroyed"
  end
end
