class CreateTMentions < ActiveRecord::Migration[5.2]
  def change
    create_table :t_mentions, id: false do |t|
      t.integer :mention_id, null: false
      t.integer :mentioned_id
      t.integer :workspace_id
      t.string :mention_message
      t.integer :login_user_id
      t.integer :chmsgmen_id
      t.timestamps
    end
    execute "ALTER TABLE t_mentions ADD PRIMARY KEY (mention_id,mentioned_id,workspace_id);"
    #execute "ALTER TABLE t_mentions CHANGE mention_id mention_id BIGINT(20) NOT NULL AUTO_INCREMENT;"
    execute <<-SQL
      CREATE SEQUENCE t_mentions_id_seq START 1;
      ALTER SEQUENCE t_mentions_id_seq OWNED BY t_mentions.mention_id;
      ALTER TABLE t_mentions ALTER COLUMN mention_id SET DEFAULT nextval('t_mentions_id_seq');
    SQL
  end
end
