json.extract! ligne_facture, :id, :produit_id, :facture_id, :quantite, :prixUnitaireHT, :created_at, :updated_at
json.url ligne_facture_url(ligne_facture, format: :json)
