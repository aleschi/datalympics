json.extract! etat_depense, :id, :date, :beneficiaire, :titre, :categorie, :ae_prevu, :ae_conso, :cp_prevu, :cp_conso, :created_at, :updated_at
json.url etat_depense_url(etat_depense, format: :json)
