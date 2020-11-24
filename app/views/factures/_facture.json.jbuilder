json.extract! facture, :id, :date, :montantTTC, :montantHT, :montantTVA, :estValide, :estRegle, :modeReglement, :created_at, :updated_at
json.url facture_url(facture, format: :json)
