class CreateHChmessageReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :h_chmessage_replies, id: false, primary_key: :chmsgrp_id do |t|
      t.primary_key :chmsgrp_id
      t.string :chthreadmsg
      t.integer :chmsg_id
      t.integer :chreplyer_id
      t.timestamps
    end
  end
end
