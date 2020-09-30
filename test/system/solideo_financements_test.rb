require "application_system_test_case"

class SolideoFinancementsTest < ApplicationSystemTestCase
  setup do
    @solideo_financement = solideo_financements(:one)
  end

  test "visiting the index" do
    visit solideo_financements_url
    assert_selector "h1", text: "Solideo Financements"
  end

  test "creating a Solideo financement" do
    visit solideo_financements_url
    click_on "New Solideo Financement"

    fill_in "Financement 2018", with: @solideo_financement.financement_2018
    fill_in "Financement 2019", with: @solideo_financement.financement_2019
    fill_in "Financement 2020", with: @solideo_financement.financement_2020
    fill_in "Financement 2021", with: @solideo_financement.financement_2021
    fill_in "Financement 2022", with: @solideo_financement.financement_2022
    fill_in "Financement 2023", with: @solideo_financement.financement_2023
    fill_in "Financement 2024", with: @solideo_financement.financement_2024
    fill_in "Financement 2025", with: @solideo_financement.financement_2025
    fill_in "Financement prevu", with: @solideo_financement.financement_prevu
    fill_in "Financeur", with: @solideo_financement.financeur
    click_on "Create Solideo financement"

    assert_text "Solideo financement was successfully created"
    click_on "Back"
  end

  test "updating a Solideo financement" do
    visit solideo_financements_url
    click_on "Edit", match: :first

    fill_in "Financement 2018", with: @solideo_financement.financement_2018
    fill_in "Financement 2019", with: @solideo_financement.financement_2019
    fill_in "Financement 2020", with: @solideo_financement.financement_2020
    fill_in "Financement 2021", with: @solideo_financement.financement_2021
    fill_in "Financement 2022", with: @solideo_financement.financement_2022
    fill_in "Financement 2023", with: @solideo_financement.financement_2023
    fill_in "Financement 2024", with: @solideo_financement.financement_2024
    fill_in "Financement 2025", with: @solideo_financement.financement_2025
    fill_in "Financement prevu", with: @solideo_financement.financement_prevu
    fill_in "Financeur", with: @solideo_financement.financeur
    click_on "Update Solideo financement"

    assert_text "Solideo financement was successfully updated"
    click_on "Back"
  end

  test "destroying a Solideo financement" do
    visit solideo_financements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Solideo financement was successfully destroyed"
  end
end
