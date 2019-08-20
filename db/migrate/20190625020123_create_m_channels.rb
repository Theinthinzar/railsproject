class CreateMChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :m_channels, id: false do |t|
      t.integer :channel_id, null: false
      t.string :channel_name
      t.integer :user_id
      t.integer :workspace_id
      t.boolean :status

      t.timestamps
    end
    execute "ALTER TABLE m_channels ADD PRIMARY KEY (channel_id,user_id,workspace_id);"
    #execute "ALTER TABLE m_channels CHANGE channel_id channel_id BIGINT(20) NOT NULL AUTO_INCREMENT;"

    execute <<-SQL
      CREATE SEQUENCE m_channels_id_seq START 1;
      ALTER SEQUENCE m_channels_id_seq OWNED BY m_channels.channel_id;
      ALTER TABLE m_channels ALTER COLUMN channel_id SET DEFAULT nextval('m_channels_id_seq');
    SQL
  end
end
