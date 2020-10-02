require 'test_helper'

class OuvragesDepensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ouvrages_depense = ouvrages_depenses(:one)
  end

  test "should get index" do
    get ouvrages_depenses_url
    assert_response :success
  end

  test "should get new" do
    get new_ouvrages_depense_url
    assert_response :success
  end

  test "should create ouvrages_depense" do
    assert_difference('OuvragesDepense.count') do
      post ouvrages_depenses_url, params: { ouvrages_depense: { date: @ouvrages_depense.date, montant: @ouvrages_depense.montant, name: @ouvrages_depense.name, ouvrage_id: @ouvrages_depense.ouvrage_id } }
    end

    assert_redirected_to ouvrages_depense_url(OuvragesDepense.last)
  end

  test "should show ouvrages_depense" do
    get ouvrages_depense_url(@ouvrages_depense)
    assert_response :success
  end

  test "should get edit" do
    get edit_ouvrages_depense_url(@ouvrages_depense)
    assert_response :success
  end

  test "should update ouvrages_depense" do
    patch ouvrages_depense_url(@ouvrages_depense), params: { ouvrages_depense: { date: @ouvrages_depense.date, montant: @ouvrages_depense.montant, name: @ouvrages_depense.name, ouvrage_id: @ouvrages_depense.ouvrage_id } }
    assert_redirected_to ouvrages_depense_url(@ouvrages_depense)
  end

  test "should destroy ouvrages_depense" do
    assert_difference('OuvragesDepense.count', -1) do
      delete ouvrages_depense_url(@ouvrages_depense)
    end

    assert_redirected_to ouvrages_depenses_url
  end
end
