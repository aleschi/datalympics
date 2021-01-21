require "application_system_test_case"

class ChorusTest < ApplicationSystemTestCase
  setup do
    @choru = chorus(:one)
  end

  test "visiting the index" do
    visit chorus_url
    assert_selector "h1", text: "Chorus"
  end

  test "creating a Choru" do
    visit chorus_url
    click_on "New Choru"

    fill_in "Centre financier", with: @choru.centre_financier
    fill_in "Compte budgetaire", with: @choru.compte_budgetaire
    fill_in "Date", with: @choru.date
    fill_in "Montant", with: @choru.montant
    fill_in "Operation", with: @choru.operation
    fill_in "Type budget", with: @choru.type_budget
    fill_in "Type piece", with: @choru.type_piece
    click_on "Create Choru"

    assert_text "Choru was successfully created"
    click_on "Back"
  end

  test "updating a Choru" do
    visit chorus_url
    click_on "Edit", match: :first

    fill_in "Centre financier", with: @choru.centre_financier
    fill_in "Compte budgetaire", with: @choru.compte_budgetaire
    fill_in "Date", with: @choru.date
    fill_in "Montant", with: @choru.montant
    fill_in "Operation", with: @choru.operation
    fill_in "Type budget", with: @choru.type_budget
    fill_in "Type piece", with: @choru.type_piece
    click_on "Update Choru"

    assert_text "Choru was successfully updated"
    click_on "Back"
  end

  test "destroying a Choru" do
    visit chorus_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Choru was successfully destroyed"
  end
end
