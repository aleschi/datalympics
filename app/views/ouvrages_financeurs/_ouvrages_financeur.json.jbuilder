json.extract! ouvrages_financeur, :id, :ouvrage_id, :name, :financement_prevu, :financement_actuel, :created_at, :updated_at
json.url ouvrages_financeur_url(ouvrages_financeur, format: :json)
