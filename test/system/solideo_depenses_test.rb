require "application_system_test_case"

class SolideoDepensesTest < ApplicationSystemTestCase
  setup do
    @solideo_depense = solideo_depenses(:one)
  end

  test "visiting the index" do
    visit solideo_depenses_url
    assert_selector "h1", text: "Solideo Depenses"
  end

  test "creating a Solideo depense" do
    visit solideo_depenses_url
    click_on "New Solideo Depense"

    fill_in "Date", with: @solideo_depense.date
    fill_in "Details", with: @solideo_depense.details
    fill_in "Montant", with: @solideo_depense.montant
    fill_in "Type", with: @solideo_depense.type
    click_on "Create Solideo depense"

    assert_text "Solideo depense was successfully created"
    click_on "Back"
  end

  test "updating a Solideo depense" do
    visit solideo_depenses_url
    click_on "Edit", match: :first

    fill_in "Date", with: @solideo_depense.date
    fill_in "Details", with: @solideo_depense.details
    fill_in "Montant", with: @solideo_depense.montant
    fill_in "Type", with: @solideo_depense.type
    click_on "Update Solideo depense"

    assert_text "Solideo depense was successfully updated"
    click_on "Back"
  end

  test "destroying a Solideo depense" do
    visit solideo_depenses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Solideo depense was successfully destroyed"
  end
end
