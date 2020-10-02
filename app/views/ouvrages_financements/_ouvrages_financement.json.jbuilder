json.extract! ouvrages_financement, :id, :date, :ouvrage_id, :name, :montant, :created_at, :updated_at
json.url ouvrages_financement_url(ouvrages_financement, format: :json)
