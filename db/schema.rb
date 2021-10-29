# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_29_084023) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "chorus", force: :cascade do |t|
    t.date "date"
    t.string "type_piece"
    t.string "type_budget"
    t.string "operation"
    t.string "centre_financier"
    t.string "compte_budgetaire"
    t.float "montant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "domaine_fonctionnel"
    t.string "type_ae", default: "cp"
  end

  create_table "chorus_nomenclatures", force: :cascade do |t|
    t.string "nom"
    t.string "designation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chorusconsos", force: :cascade do |t|
    t.string "centre_financier"
    t.string "action"
    t.date "date"
    t.integer "ae_conso"
    t.integer "cp_conso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "epreuves"
    t.integer "ouvrages_public_id"
    t.index ["ouvrages_public_id"], name: "index_disciplines_on_ouvrages_public_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "appartenance"
    t.string "extension"
    t.date "date"
  end

  create_table "echeancierinnovations", force: :cascade do |t|
    t.integer "innovation_id"
    t.date "date"
    t.float "montant"
    t.boolean "versement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["innovation_id"], name: "index_echeancierinnovations_on_innovation_id"
  end

  create_table "etat_budgets", force: :cascade do |t|
    t.datetime "date"
    t.float "budget_total"
    t.float "budget_solideo"
    t.float "budget_cojo"
    t.float "budget_heritage"
    t.float "budget_hauteperformance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "etat_depenses", force: :cascade do |t|
    t.date "date"
    t.string "beneficiaire"
    t.integer "titre"
    t.integer "categorie"
    t.float "ae_prevu"
    t.float "ae_conso"
    t.float "cp_prevu"
    t.float "cp_conso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "innovations", force: :cascade do |t|
    t.string "nom"
    t.string "porteur"
    t.integer "ouvrage_id"
    t.float "dotation"
    t.date "date"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ouvrage_id"], name: "index_innovations_on_ouvrage_id"
  end

  create_table "maquettes", force: :cascade do |t|
    t.string "name"
    t.integer "ouvrage_id"
    t.integer "total"
    t.integer "total_complementaire"
    t.integer "total_public"
    t.date "date"
    t.string "commentaire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ouvrage_id"], name: "index_maquettes_on_ouvrage_id"
  end

  create_table "ouvrages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "maitre_oeuvre"
    t.float "budget"
    t.string "adresse"
    t.float "latitude"
    t.float "longitude"
    t.string "description"
    t.string "phase_jo"
    t.string "heritage"
    t.date "date"
    t.date "start"
    t.date "end"
  end

  create_table "ouvrages_depenses", force: :cascade do |t|
    t.date "date"
    t.integer "ouvrage_id"
    t.string "name"
    t.float "montant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "montant_engage"
    t.float "montant_prevu"
    t.date "date_maquette"
    t.index ["ouvrage_id"], name: "index_ouvrages_depenses_on_ouvrage_id"
  end

  create_table "ouvrages_financements", force: :cascade do |t|
    t.date "date"
    t.integer "ouvrage_id"
    t.string "name"
    t.float "montant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "montant_prevu"
    t.index ["ouvrage_id"], name: "index_ouvrages_financements_on_ouvrage_id"
  end

  create_table "ouvrages_publics", force: :cascade do |t|
    t.string "nom"
    t.string "travaux"
    t.string "appartenance"
    t.string "adresse"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "ouvrage_id"
    t.index ["ouvrage_id"], name: "index_ouvrages_publics_on_ouvrage_id"
  end

  create_table "solideo_depenses", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "ouvrages"
    t.float "fonctionnement"
    t.float "reserve"
    t.float "innovation"
  end

  create_table "solideo_financements", force: :cascade do |t|
    t.string "financeur"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.float "montant_prevu"
    t.float "montant"
    t.string "categorie"
  end

  create_table "solideo_financeur_budgets", force: :cascade do |t|
    t.date "date"
    t.float "financement_global"
    t.integer "solideo_financeur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solideo_financeur_id"], name: "index_solideo_financeur_budgets_on_solideo_financeur_id"
  end

  create_table "solideo_financeur_financements", force: :cascade do |t|
    t.date "date"
    t.float "titres_emis"
    t.float "encaissements"
    t.integer "solideo_financeur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solideo_financeur_id"], name: "index_solideo_financeur_financements_on_solideo_financeur_id"
  end

  create_table "solideo_financeurs", force: :cascade do |t|
    t.string "name"
    t.string "categorie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solideo_structure_budgets", force: :cascade do |t|
    t.date "date"
    t.float "budget_global"
    t.float "budget_annee"
    t.integer "solideo_structure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solideo_structure_id"], name: "index_solideo_structure_budgets_on_solideo_structure_id"
  end

  create_table "solideo_structure_depenses", force: :cascade do |t|
    t.date "date"
    t.float "droits_constates_cumul"
    t.float "droits_constates_annee"
    t.float "montants_engages_cumul"
    t.integer "solideo_structure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solideo_structure_id"], name: "index_solideo_structure_depenses_on_solideo_structure_id"
  end

  create_table "solideo_structures", force: :cascade do |t|
    t.string "name"
    t.string "categorie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "typeinnovations", force: :cascade do |t|
    t.integer "innovation_id"
    t.string "categorie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["innovation_id"], name: "index_typeinnovations_on_innovation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
