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

ActiveRecord::Schema.define(version: 2020_10_22_092114) do

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

  create_table "ouvrages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "maitre_oeuvre"
    t.float "budget"
    t.string "adresse"
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

  create_table "ouvrages_financeurs", force: :cascade do |t|
    t.integer "ouvrage_id"
    t.string "name"
    t.float "financement_prevu"
    t.float "financement_actuel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ouvrage_id"], name: "index_ouvrages_financeurs_on_ouvrage_id"
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

end
