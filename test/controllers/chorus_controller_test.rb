require 'test_helper'

class ChorusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @choru = chorus(:one)
  end

  test "should get index" do
    get chorus_url
    assert_response :success
  end

  test "should get new" do
    get new_choru_url
    assert_response :success
  end

  test "should create choru" do
    assert_difference('Choru.count') do
      post chorus_url, params: { choru: { centre_financier: @choru.centre_financier, compte_budgetaire: @choru.compte_budgetaire, date: @choru.date, montant: @choru.montant, operation: @choru.operation, type_budget: @choru.type_budget, type_piece: @choru.type_piece } }
    end

    assert_redirected_to choru_url(Choru.last)
  end

  test "should show choru" do
    get choru_url(@choru)
    assert_response :success
  end

  test "should get edit" do
    get edit_choru_url(@choru)
    assert_response :success
  end

  test "should update choru" do
    patch choru_url(@choru), params: { choru: { centre_financier: @choru.centre_financier, compte_budgetaire: @choru.compte_budgetaire, date: @choru.date, montant: @choru.montant, operation: @choru.operation, type_budget: @choru.type_budget, type_piece: @choru.type_piece } }
    assert_redirected_to choru_url(@choru)
  end

  test "should destroy choru" do
    assert_difference('Choru.count', -1) do
      delete choru_url(@choru)
    end

    assert_redirected_to chorus_url
  end
end
