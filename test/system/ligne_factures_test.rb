require "application_system_test_case"

class LigneFacturesTest < ApplicationSystemTestCase
  setup do
    @ligne_facture = ligne_factures(:one)
  end

  test "visiting the index" do
    visit ligne_factures_url
    assert_selector "h1", text: "Ligne Factures"
  end

  test "creating a Ligne facture" do
    visit ligne_factures_url
    click_on "New Ligne Facture"

    fill_in "Facture", with: @ligne_facture.facture_id
    fill_in "Prixunitaireht", with: @ligne_facture.prixUnitaireHT
    fill_in "Produit", with: @ligne_facture.produit_id
    fill_in "Quantite", with: @ligne_facture.quantite
    click_on "Create Ligne facture"

    assert_text "Ligne facture was successfully created"
    click_on "Back"
  end

  test "updating a Ligne facture" do
    visit ligne_factures_url
    click_on "Edit", match: :first

    fill_in "Facture", with: @ligne_facture.facture_id
    fill_in "Prixunitaireht", with: @ligne_facture.prixUnitaireHT
    fill_in "Produit", with: @ligne_facture.produit_id
    fill_in "Quantite", with: @ligne_facture.quantite
    click_on "Update Ligne facture"

    assert_text "Ligne facture was successfully updated"
    click_on "Back"
  end

  test "destroying a Ligne facture" do
    visit ligne_factures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ligne facture was successfully destroyed"
  end
end
