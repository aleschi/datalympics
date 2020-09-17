require 'test_helper'

class EtatBudgetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @etat_budget = etat_budgets(:one)
  end

  test "should get index" do
    get etat_budgets_url
    assert_response :success
  end

  test "should get new" do
    get new_etat_budget_url
    assert_response :success
  end

  test "should create etat_budget" do
    assert_difference('EtatBudget.count') do
      post etat_budgets_url, params: { etat_budget: { budget_cojo: @etat_budget.budget_cojo, budget_hauteperformance: @etat_budget.budget_hauteperformance, budget_heritage: @etat_budget.budget_heritage, budget_solideo: @etat_budget.budget_solideo, budget_total: @etat_budget.budget_total, date: @etat_budget.date } }
    end

    assert_redirected_to etat_budget_url(EtatBudget.last)
  end

  test "should show etat_budget" do
    get etat_budget_url(@etat_budget)
    assert_response :success
  end

  test "should get edit" do
    get edit_etat_budget_url(@etat_budget)
    assert_response :success
  end

  test "should update etat_budget" do
    patch etat_budget_url(@etat_budget), params: { etat_budget: { budget_cojo: @etat_budget.budget_cojo, budget_hauteperformance: @etat_budget.budget_hauteperformance, budget_heritage: @etat_budget.budget_heritage, budget_solideo: @etat_budget.budget_solideo, budget_total: @etat_budget.budget_total, date: @etat_budget.date } }
    assert_redirected_to etat_budget_url(@etat_budget)
  end

  test "should destroy etat_budget" do
    assert_difference('EtatBudget.count', -1) do
      delete etat_budget_url(@etat_budget)
    end

    assert_redirected_to etat_budgets_url
  end
end
