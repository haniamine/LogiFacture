class CreateProduits < ActiveRecord::Migration[6.0]
  def change
    create_table :produits do |t|
      t.string :libelle
      t.float :prixHT
      t.float :tauxTVA

      t.timestamps
    end
  end
end
