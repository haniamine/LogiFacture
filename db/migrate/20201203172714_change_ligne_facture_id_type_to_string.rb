class ChangeLigneFactureIdTypeToString < ActiveRecord::Migration[6.0]
  def change
    change_column :ligne_factures, :facture_id, :string
  end
end
