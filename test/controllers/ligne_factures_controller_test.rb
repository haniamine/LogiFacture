require 'test_helper'

class LigneFacturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ligne_facture = ligne_factures(:one)
  end

  test "should get index" do
    get ligne_factures_url
    assert_response :success
  end

  test "should get new" do
    get new_ligne_facture_url
    assert_response :success
  end

  test "should create ligne_facture" do
    assert_difference('LigneFacture.count') do
      post ligne_factures_url, params: { ligne_facture: { facture_id: @ligne_facture.facture_id, prixUnitaireHT: @ligne_facture.prixUnitaireHT, produit_id: @ligne_facture.produit_id, quantite: @ligne_facture.quantite } }
    end

    assert_redirected_to ligne_facture_url(LigneFacture.last)
  end

  test "should show ligne_facture" do
    get ligne_facture_url(@ligne_facture)
    assert_response :success
  end

  test "should get edit" do
    get edit_ligne_facture_url(@ligne_facture)
    assert_response :success
  end

  test "should update ligne_facture" do
    patch ligne_facture_url(@ligne_facture), params: { ligne_facture: { facture_id: @ligne_facture.facture_id, prixUnitaireHT: @ligne_facture.prixUnitaireHT, produit_id: @ligne_facture.produit_id, quantite: @ligne_facture.quantite } }
    assert_redirected_to ligne_facture_url(@ligne_facture)
  end

  test "should destroy ligne_facture" do
    assert_difference('LigneFacture.count', -1) do
      delete ligne_facture_url(@ligne_facture)
    end

    assert_redirected_to ligne_factures_url
  end
end
