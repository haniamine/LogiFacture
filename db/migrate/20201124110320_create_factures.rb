class CreateFactures < ActiveRecord::Migration[6.0]
  def change
    create_table :factures do |t|
      t.datetime :date
      t.float :montantTTC
      t.float :montantHT
      t.integer :montantTVA
      t.integer :estValide
      t.integer :estRegle
      t.string :modeReglement

      t.timestamps
    end
  end
end
