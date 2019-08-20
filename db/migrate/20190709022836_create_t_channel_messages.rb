class CreateTChannelMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :t_channel_messages, id: false, primary_key: :chmsg_id do |t|
      t.primary_key :chmsg_id

      t.string :chmessage

      t.references :m_user, references: :m_users, null: false
      t.references :m_channel, references: :m_channels, null: false

      t.timestamps
    end

    rename_column :t_channel_messages, :m_user_id, :chsender_id
    add_foreign_key :t_channel_messages, :m_users, column: "chsender_id", primary_key: "user_id"

    rename_column :t_channel_messages, :m_channel_id, :channel_id
    add_foreign_key :t_channel_messages, :m_channels, column: "channel_id", primary_key: "channel_id"
  end
end
