json.extract! ouvrages_depense, :id, :date, :ouvrage_id, :name, :montant, :created_at, :updated_at
json.url ouvrages_depense_url(ouvrages_depense, format: :json)
