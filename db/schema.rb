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

ActiveRecord::Schema.define(version: 2019_07_26_031302) do

  create_table "h_chmessage_replies", primary_key: "chmsgrp_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "chthreadmsg"
    t.bigint "chmsgid", null: false
    t.bigint "chreplyer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chmsgid"], name: "index_h_chmessage_replies_on_chmsgid"
    t.index ["chreplyer_id"], name: "index_h_chmessage_replies_on_chreplyer_id"
  end

  create_table "h_dirmessage_replies", primary_key: "dirmsgrp_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "dirthread_msg"
    t.boolean "is_read"
    t.bigint "reply_user_id", null: false
    t.bigint "dirmsg_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dirmsg_id"], name: "index_h_dirmessage_replies_on_dirmsg_id"
    t.index ["reply_user_id"], name: "index_h_dirmessage_replies_on_reply_user_id"
  end

  create_table "m_channels", primary_key: ["channel_id", "user_id", "workspace_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "channel_id", null: false, auto_increment: true
    t.string "channel_name"
    t.integer "user_id", null: false
    t.integer "workspace_id", null: false
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "chadmin"
  end

  create_table "m_users", primary_key: "user_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_name"
    t.string "user_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "m_workspaces", primary_key: ["workspace_id", "user_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "workspace_id", null: false, auto_increment: true
    t.integer "user_id", null: false
    t.string "workspace_name"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_channel_messages", primary_key: "chmsg_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "chmessage"
    t.bigint "chsender_id", null: false
    t.bigint "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count"
    t.index ["channel_id"], name: "index_t_channel_messages_on_channel_id"
    t.index ["chsender_id"], name: "index_t_channel_messages_on_chsender_id"
  end

  create_table "t_chmsgstars", primary_key: "chstar_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "chmsgstarid", null: false
    t.bigint "chstar_userid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chmsgstarid"], name: "index_t_chmsgstars_on_chmsgstarid"
    t.index ["chstar_userid"], name: "index_t_chmsgstars_on_chstar_userid"
  end

  create_table "t_chunread_messages", primary_key: ["chunmsg_id", "chmsg_id", "chuser_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "chunmsg_id", null: false, auto_increment: true
    t.integer "chmsg_id", null: false
    t.integer "chuser_id", null: false
    t.boolean "is_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "t_directstars", primary_key: "dstar_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "star_userid", null: false
    t.bigint "stardimsg_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["star_userid"], name: "index_t_directstars_on_star_userid"
    t.index ["stardimsg_id"], name: "index_t_directstars_on_stardimsg_id"
  end

  create_table "t_dirmessages", primary_key: "dirmsg_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "sender_user_id"
    t.integer "receiver_user_id"
    t.string "dir_message"
    t.boolean "is_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dirworkspace_id"
    t.integer "count"
  end

  create_table "t_mentions", primary_key: ["mention_id", "mentioned_id", "workspace_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "mention_id", null: false, auto_increment: true
    t.integer "mentioned_id", null: false
    t.integer "workspace_id", null: false
    t.string "mention_message"
    t.bigint "login_user_id", null: false
    t.bigint "chmsgmen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chmsgmen_id"], name: "index_t_mentions_on_chmsgmen_id"
    t.index ["login_user_id"], name: "index_t_mentions_on_login_user_id"
  end

  add_foreign_key "h_chmessage_replies", "m_users", column: "chreplyer_id", primary_key: "user_id"
  add_foreign_key "h_chmessage_replies", "t_channel_messages", column: "chmsgid", primary_key: "chmsg_id"
  add_foreign_key "h_dirmessage_replies", "m_users", column: "reply_user_id", primary_key: "user_id"
  add_foreign_key "h_dirmessage_replies", "t_dirmessages", column: "dirmsg_id", primary_key: "dirmsg_id"
  add_foreign_key "t_channel_messages", "m_channels", column: "channel_id", primary_key: "channel_id"
  add_foreign_key "t_channel_messages", "m_users", column: "chsender_id", primary_key: "user_id"
  add_foreign_key "t_chmsgstars", "m_users", column: "chstar_userid", primary_key: "user_id"
  add_foreign_key "t_chmsgstars", "t_channel_messages", column: "chmsgstarid", primary_key: "chmsg_id"
  add_foreign_key "t_directstars", "m_users", column: "star_userid", primary_key: "user_id"
  add_foreign_key "t_directstars", "t_dirmessages", column: "stardimsg_id", primary_key: "dirmsg_id"
  add_foreign_key "t_mentions", "m_channels", column: "chmsgmen_id", primary_key: "channel_id"
  add_foreign_key "t_mentions", "m_users", column: "login_user_id", primary_key: "user_id"
end
