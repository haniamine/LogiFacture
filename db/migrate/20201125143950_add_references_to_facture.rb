class AddReferencesToFacture < ActiveRecord::Migration[6.0]
  def change
    add_reference :factures, :client,  foreign_key: true
    add_reference :factures, :user,  foreign_key: true
    change_column_default :factures, :estRegle, 0
    change_column_default :factures, :estValide, 0
  end
end
