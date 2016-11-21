# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161121013327) do

  create_table "answergroups", force: :cascade do |t|
    t.integer  "qcd_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "answergroups", ["qcd_id"], name: "index_answergroups_on_qcd_id"

  create_table "answers", force: :cascade do |t|
    t.integer  "qcd_id"
    t.integer  "order"
    t.string   "answer"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "answergroup_id"
  end

  add_index "answers", ["answergroup_id"], name: "index_answers_on_answergroup_id"
  add_index "answers", ["qcd_id"], name: "index_answers_on_qcd_id"

  create_table "asignaturas", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "division"
    t.string   "dpto"
    t.string   "programa"
    t.string   "nombre"
    t.integer  "nrc"
    t.string   "semestre"
    t.integer  "creditos"
    t.string   "objetivo1"
    t.string   "objetivo2"
    t.string   "objetivo3"
    t.string   "objetivo4"
    t.string   "objetivo5"
    t.string   "objetivo6"
    t.string   "objetivo7"
    t.string   "objetivo8"
    t.string   "objetivo9"
    t.string   "objetivo10"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "asignaturas", ["user_id"], name: "index_asignaturas_on_user_id"

  create_table "qcds", force: :cascade do |t|
    t.integer  "asignatura_id"
    t.string   "salon"
    t.datetime "fecha"
    t.boolean  "grupo"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "qcds", ["asignatura_id"], name: "index_qcds_on_asignatura_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.boolean  "admin"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "ubicacion"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
