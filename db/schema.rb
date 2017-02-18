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

ActiveRecord::Schema.define(version: 20170209203250) do

  create_table "person_analyses", force: :cascade do |t|
    t.string  "author"
    t.integer "user_id"
    t.integer "word_count"
    t.integer "agreeableness"
    t.integer "conscientiousness"
    t.integer "extraversion"
    t.integer "emotional_range"
    t.integer "openness"
    t.integer "challenge"
    t.integer "closeness"
    t.integer "curiosity"
    t.integer "excitement"
    t.integer "harmony"
    t.integer "ideal"
    t.integer "liberty"
    t.integer "love"
    t.integer "practicality"
    t.integer "self_expression"
    t.integer "stability"
    t.integer "structure"
    t.integer "conservation"
    t.integer "openness_to_change"
    t.integer "hedonism"
    t.integer "self_enhancement"
    t.integer "self_transcendence"
  end

  create_table "the_tone_analyses", force: :cascade do |t|
    t.string  "author"
    t.string  "tone_text"
    t.integer "user_id"
    t.integer "anger"
    t.integer "disgust"
    t.integer "fear"
    t.integer "joy"
    t.integer "sadness"
    t.integer "analytical"
    t.integer "confident"
    t.integer "tentative"
    t.integer "openness"
    t.integer "conscientiousness"
    t.integer "extraversion"
    t.integer "agreeableness"
    t.integer "emotional_range"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
