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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20200916181815) do

  create_table "addresses", :force => true do |t|
    t.string  "first_line"
    t.string  "second_line"
    t.string  "city"
    t.integer "pincode"
    t.string  "name"
    t.integer "employee_id"
  end

  create_table "educations", :force => true do |t|
    t.string  "tenth_school"
    t.float   "tenth_grade"
    t.string  "twelfth_school"
    t.float   "twelfth_grade"
    t.string  "ug_university"
    t.float   "ug_grade"
    t.integer "employee_id"
  end

  create_table "employees", :force => true do |t|
    t.integer  "employee_id"
    t.string   "employee_name"
    t.string   "employee_email"
    t.integer  "squad_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "personals", :force => true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.date    "dob"
    t.string  "gender"
    t.string  "nativity"
    t.string  "phone_number"
    t.string  "work_number"
    t.integer "employee_id"
  end

  create_table "squads", :force => true do |t|
    t.string   "squad_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
