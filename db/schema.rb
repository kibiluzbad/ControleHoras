# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100225214319) do

  create_table "lancamentos", :force => true do |t|
    t.time      "entrada"
    t.time      "saida"
    t.string    "descricao"
    t.decimal   "horas"
    t.decimal   "horas_extras"
    t.date      "data"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.decimal   "total"
    t.boolean   "almoco"
    t.time      "almoco_saida"
    t.time      "almoco_volta"
    t.boolean   "pago"
    t.integer   "user_id"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "users", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "identity_url"
    t.string    "nickname"
    t.string    "email"
    t.string    "fullname"
  end

end
