class LigneFacture < ApplicationRecord
  belongs_to :produit
  belongs_to :facture
end
