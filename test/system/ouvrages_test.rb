require "application_system_test_case"

class OuvragesTest < ApplicationSystemTestCase
  setup do
    @ouvrage = ouvrages(:one)
  end

  test "visiting the index" do
    visit ouvrages_url
    assert_selector "h1", text: "Ouvrages"
  end

  test "creating a Ouvrage" do
    visit ouvrages_url
    click_on "New Ouvrage"

    fill_in "Name", with: @ouvrage.name
    click_on "Create Ouvrage"

    assert_text "Ouvrage was successfully created"
    click_on "Back"
  end

  test "updating a Ouvrage" do
    visit ouvrages_url
    click_on "Edit", match: :first

    fill_in "Name", with: @ouvrage.name
    click_on "Update Ouvrage"

    assert_text "Ouvrage was successfully updated"
    click_on "Back"
  end

  test "destroying a Ouvrage" do
    visit ouvrages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ouvrage was successfully destroyed"
  end
end
