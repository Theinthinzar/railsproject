class CreateMChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :m_channels, id: false do |t|
      t.integer :channel_id
      t.string :channel_name
      t.integer :user_id
      t.integer :workspace_id
      t.boolean :status

      t.timestamps
    end
    execute "ALTER TABLE m_channels ADD PRIMARY KEY (channel_id,user_id,workspace_id);"
    execute "ALTER TABLE m_channels CHANGE channel_id channel_id BIGINT(20) NOT NULL AUTO_INCREMENT;"
  end
end
