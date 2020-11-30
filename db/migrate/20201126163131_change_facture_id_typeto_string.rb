class ChangeFactureIdTypetoString < ActiveRecord::Migration[6.0]
  def change
    change_column :factures, :id, :string
  end
end
