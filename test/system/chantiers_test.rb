require "application_system_test_case"

class ChantiersTest < ApplicationSystemTestCase
  setup do
    @chantier = chantiers(:one)
  end

  test "visiting the index" do
    visit chantiers_url
    assert_selector "h1", text: "Chantiers"
  end

  test "creating a Chantier" do
    visit chantiers_url
    click_on "New Chantier"

    fill_in "Name", with: @chantier.name
    fill_in "Ouvrage", with: @chantier.ouvrage_id
    click_on "Create Chantier"

    assert_text "Chantier was successfully created"
    click_on "Back"
  end

  test "updating a Chantier" do
    visit chantiers_url
    click_on "Edit", match: :first

    fill_in "Name", with: @chantier.name
    fill_in "Ouvrage", with: @chantier.ouvrage_id
    click_on "Update Chantier"

    assert_text "Chantier was successfully updated"
    click_on "Back"
  end

  test "destroying a Chantier" do
    visit chantiers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Chantier was successfully destroyed"
  end
end
