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

ActiveRecord::Schema.define(version: 2020_09_30_133353) do

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
    t.datetime "date"
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
  end

  create_table "solideo_depenses", force: :cascade do |t|
    t.date "date"
    t.float "montant"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "categorie"
  end

  create_table "solideo_financements", force: :cascade do |t|
    t.string "financeur"
    t.float "financement_prevu"
    t.float "financement_2018"
    t.float "financement_2019"
    t.float "financement_2020"
    t.float "financement_2021"
    t.float "financement_2022"
    t.float "financement_2023"
    t.float "financement_2024"
    t.float "financement_2025"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
