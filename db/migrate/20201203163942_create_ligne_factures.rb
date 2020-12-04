class CreateLigneFactures < ActiveRecord::Migration[6.0]
  def change
    create_table :ligne_factures do |t|
      t.references :produit, null: false, foreign_key: true
      t.references :facture, null: false, foreign_key: true
      t.integer :quantite
      t.float :prixUnitaireHT

      t.timestamps
    end
  end
end
