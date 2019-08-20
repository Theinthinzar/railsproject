class CreateHDirmessageReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :h_dirmessage_replies, id: false, primary_key: :dirmsgrp_id do |t|
      t.primary_key :dirmsgrp_id

      t.string :dirthread_msg
      t.boolean :is_read

      t.references :m_user, references: :m_users, null: false
      t.references :t_dirmessage, references: :t_dirmessages, null: false

      t.timestamps
    end
    rename_column :h_dirmessage_replies, :m_user_id, :reply_user_id
    add_foreign_key :h_dirmessage_replies, :m_users, column: "reply_user_id", primary_key: "user_id"

    rename_column :h_dirmessage_replies, :t_dirmessage_id, :dirmsg_id
    add_foreign_key :h_dirmessage_replies, :t_dirmessages, column: "dirmsg_id", primary_key: "dirmsg_id"
  end
end
