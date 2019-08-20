class CreateTMentions < ActiveRecord::Migration[5.2]
  def change
    create_table :t_mentions, id: false do |t|
      t.integer :mention_id
      t.integer :mentioned_id
      t.integer :workspace_id
      t.string :mention_message
      t.references :m_user, references: :m_users, null: false
      t.references :m_channel, references: :m_channels, null: false

      t.timestamps
    end
    execute "ALTER TABLE t_mentions ADD PRIMARY KEY (mention_id,mentioned_id,workspace_id);"
    execute "ALTER TABLE t_mentions CHANGE mention_id mention_id BIGINT(20) NOT NULL AUTO_INCREMENT;"
    rename_column :t_mentions, :m_user_id, :login_user_id
    add_foreign_key :t_mentions, :m_users, column: "login_user_id", primary_key: "user_id"

    rename_column :t_mentions, :m_channel_id, :chmsgmen_id
    add_foreign_key :t_mentions, :m_channels, column: "chmsgmen_id", primary_key: "channel_id"
  end
end
