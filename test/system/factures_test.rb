require "application_system_test_case"

class FacturesTest < ApplicationSystemTestCase
  setup do
    @facture = factures(:one)
  end

  test "visiting the index" do
    visit factures_url
    assert_selector "h1", text: "Factures"
  end

  test "creating a Facture" do
    visit factures_url
    click_on "New Facture"

    fill_in "Date", with: @facture.date
    fill_in "Estregle", with: @facture.estRegle
    fill_in "Estvalide", with: @facture.estValide
    fill_in "Modereglement", with: @facture.modeReglement
    fill_in "Montantht", with: @facture.montantHT
    fill_in "Montantttc", with: @facture.montantTTC
    fill_in "Montanttva", with: @facture.montantTVA
    click_on "Create Facture"

    assert_text "Facture was successfully created"
    click_on "Back"
  end

  test "updating a Facture" do
    visit factures_url
    click_on "Edit", match: :first

    fill_in "Date", with: @facture.date
    fill_in "Estregle", with: @facture.estRegle
    fill_in "Estvalide", with: @facture.estValide
    fill_in "Modereglement", with: @facture.modeReglement
    fill_in "Montantht", with: @facture.montantHT
    fill_in "Montantttc", with: @facture.montantTTC
    fill_in "Montanttva", with: @facture.montantTVA
    click_on "Update Facture"

    assert_text "Facture was successfully updated"
    click_on "Back"
  end

  test "destroying a Facture" do
    visit factures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Facture was successfully destroyed"
  end
end
