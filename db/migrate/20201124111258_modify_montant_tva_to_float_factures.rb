class ModifyMontantTvaToFloatFactures < ActiveRecord::Migration[6.0]
  def change
    change_column :factures, :montantTVA, :float
  end
end
