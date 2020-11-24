json.extract! produit, :id, :libelle, :prixHT, :tauxTVA, :created_at, :updated_at
json.url produit_url(produit, format: :json)
