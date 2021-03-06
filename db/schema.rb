# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_03_172714) do

  create_table "clients", force: :cascade do |t|
    t.string "nom"
    t.string "email"
    t.float "encours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "factures", id: :string, force: :cascade do |t|
    t.datetime "date"
    t.float "montantTTC"
    t.float "montantHT"
    t.float "montantTVA"
    t.integer "estValide", default: 0
    t.integer "estRegle", default: 0
    t.string "modeReglement"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "client_id"
    t.integer "user_id"
    t.index ["client_id"], name: "index_factures_on_client_id"
    t.index ["user_id"], name: "index_factures_on_user_id"
  end

  create_table "ligne_factures", force: :cascade do |t|
    t.integer "produit_id", null: false
    t.string "facture_id", null: false
    t.integer "quantite"
    t.float "prixUnitaireHT"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["facture_id"], name: "index_ligne_factures_on_facture_id"
    t.index ["produit_id"], name: "index_ligne_factures_on_produit_id"
  end

  create_table "produits", force: :cascade do |t|
    t.string "libelle"
    t.float "prixHT"
    t.float "tauxTVA"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.integer "estAdmin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "factures", "clients"
  add_foreign_key "factures", "users"
  add_foreign_key "ligne_factures", "factures"
  add_foreign_key "ligne_factures", "produits"
end
