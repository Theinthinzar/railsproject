class CreateTChmsgstars < ActiveRecord::Migration[5.2]
  def change
    create_table :t_chmsgstars, id: false, primary_key: :chstar_id do |t|
      t.primary_key :chstar_id
      t.references :t_channel_message, references: :t_channel_messages, null: false
      t.references :m_user, references: :m_users, null: false
      t.timestamps
    end
    rename_column :t_chmsgstars, :t_channel_message_id, :chmsgstarid
    add_foreign_key :t_chmsgstars, :t_channel_messages, column: "chmsgstarid", primary_key: "chmsg_id"

    rename_column :t_chmsgstars, :m_user_id, :chstar_userid
    add_foreign_key :t_chmsgstars, :m_users, column: "chstar_userid", primary_key: "user_id"
  end
end
