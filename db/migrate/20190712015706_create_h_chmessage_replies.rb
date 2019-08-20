class CreateHChmessageReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :h_chmessage_replies, id: false, primary_key: :chmsgrp_id do |t|
      t.primary_key :chmsgrp_id

      t.string :chthreadmsg

      t.references :t_channel_message, references: :t_channel_messages, null: false
      t.references :m_user, references: :m_users, null: false
      t.timestamps
    end
    rename_column :h_chmessage_replies, :t_channel_message_id, :chmsgid
    add_foreign_key :h_chmessage_replies, :t_channel_messages, column: "chmsgid", primary_key: "chmsg_id"

    rename_column :h_chmessage_replies, :m_user_id, :chreplyer_id
    add_foreign_key :h_chmessage_replies, :m_users, column: "chreplyer_id", primary_key: "user_id"
  end
end
