require 'test_helper'

class SolideoFinancementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @solideo_financement = solideo_financements(:one)
  end

  test "should get index" do
    get solideo_financements_url
    assert_response :success
  end

  test "should get new" do
    get new_solideo_financement_url
    assert_response :success
  end

  test "should create solideo_financement" do
    assert_difference('SolideoFinancement.count') do
      post solideo_financements_url, params: { solideo_financement: { financement_2018: @solideo_financement.financement_2018, financement_2019: @solideo_financement.financement_2019, financement_2020: @solideo_financement.financement_2020, financement_2021: @solideo_financement.financement_2021, financement_2022: @solideo_financement.financement_2022, financement_2023: @solideo_financement.financement_2023, financement_2024: @solideo_financement.financement_2024, financement_2025: @solideo_financement.financement_2025, financement_prevu: @solideo_financement.financement_prevu, financeur: @solideo_financement.financeur } }
    end

    assert_redirected_to solideo_financement_url(SolideoFinancement.last)
  end

  test "should show solideo_financement" do
    get solideo_financement_url(@solideo_financement)
    assert_response :success
  end

  test "should get edit" do
    get edit_solideo_financement_url(@solideo_financement)
    assert_response :success
  end

  test "should update solideo_financement" do
    patch solideo_financement_url(@solideo_financement), params: { solideo_financement: { financement_2018: @solideo_financement.financement_2018, financement_2019: @solideo_financement.financement_2019, financement_2020: @solideo_financement.financement_2020, financement_2021: @solideo_financement.financement_2021, financement_2022: @solideo_financement.financement_2022, financement_2023: @solideo_financement.financement_2023, financement_2024: @solideo_financement.financement_2024, financement_2025: @solideo_financement.financement_2025, financement_prevu: @solideo_financement.financement_prevu, financeur: @solideo_financement.financeur } }
    assert_redirected_to solideo_financement_url(@solideo_financement)
  end

  test "should destroy solideo_financement" do
    assert_difference('SolideoFinancement.count', -1) do
      delete solideo_financement_url(@solideo_financement)
    end

    assert_redirected_to solideo_financements_url
  end
end
