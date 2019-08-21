class CreateHDirmessageReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :h_dirmessage_replies, id: false, primary_key: :dirmsgrp_id do |t|
      t.primary_key :dirmsgrp_id
      t.string :dirthread_msg
      t.boolean :is_read
      t.integer :reply_user_id
      t.integer :dirmsg_id
      t.timestamps
    end
  end
end
