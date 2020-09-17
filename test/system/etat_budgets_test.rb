require "application_system_test_case"

class EtatBudgetsTest < ApplicationSystemTestCase
  setup do
    @etat_budget = etat_budgets(:one)
  end

  test "visiting the index" do
    visit etat_budgets_url
    assert_selector "h1", text: "Etat Budgets"
  end

  test "creating a Etat budget" do
    visit etat_budgets_url
    click_on "New Etat Budget"

    fill_in "Budget cojo", with: @etat_budget.budget_cojo
    fill_in "Budget hauteperformance", with: @etat_budget.budget_hauteperformance
    fill_in "Budget heritage", with: @etat_budget.budget_heritage
    fill_in "Budget solideo", with: @etat_budget.budget_solideo
    fill_in "Budget total", with: @etat_budget.budget_total
    fill_in "Date", with: @etat_budget.date
    click_on "Create Etat budget"

    assert_text "Etat budget was successfully created"
    click_on "Back"
  end

  test "updating a Etat budget" do
    visit etat_budgets_url
    click_on "Edit", match: :first

    fill_in "Budget cojo", with: @etat_budget.budget_cojo
    fill_in "Budget hauteperformance", with: @etat_budget.budget_hauteperformance
    fill_in "Budget heritage", with: @etat_budget.budget_heritage
    fill_in "Budget solideo", with: @etat_budget.budget_solideo
    fill_in "Budget total", with: @etat_budget.budget_total
    fill_in "Date", with: @etat_budget.date
    click_on "Update Etat budget"

    assert_text "Etat budget was successfully updated"
    click_on "Back"
  end

  test "destroying a Etat budget" do
    visit etat_budgets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Etat budget was successfully destroyed"
  end
end
