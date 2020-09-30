require 'test_helper'

class SolideoDepensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @solideo_depense = solideo_depenses(:one)
  end

  test "should get index" do
    get solideo_depenses_url
    assert_response :success
  end

  test "should get new" do
    get new_solideo_depense_url
    assert_response :success
  end

  test "should create solideo_depense" do
    assert_difference('SolideoDepense.count') do
      post solideo_depenses_url, params: { solideo_depense: { date: @solideo_depense.date, details: @solideo_depense.details, montant: @solideo_depense.montant, type: @solideo_depense.type } }
    end

    assert_redirected_to solideo_depense_url(SolideoDepense.last)
  end

  test "should show solideo_depense" do
    get solideo_depense_url(@solideo_depense)
    assert_response :success
  end

  test "should get edit" do
    get edit_solideo_depense_url(@solideo_depense)
    assert_response :success
  end

  test "should update solideo_depense" do
    patch solideo_depense_url(@solideo_depense), params: { solideo_depense: { date: @solideo_depense.date, details: @solideo_depense.details, montant: @solideo_depense.montant, type: @solideo_depense.type } }
    assert_redirected_to solideo_depense_url(@solideo_depense)
  end

  test "should destroy solideo_depense" do
    assert_difference('SolideoDepense.count', -1) do
      delete solideo_depense_url(@solideo_depense)
    end

    assert_redirected_to solideo_depenses_url
  end
end
