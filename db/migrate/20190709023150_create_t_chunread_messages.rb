class CreateTChunreadMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :t_chunread_messages, id: false do |t|
      t.integer :chunmsg_id
      t.integer :chmsg_id
      t.integer :chuser_id
      t.boolean :is_read

      t.timestamps
    end
    execute "ALTER TABLE t_chunread_messages ADD PRIMARY KEY (chunmsg_id,chmsg_id,chuser_id);"
    execute "ALTER TABLE t_chunread_messages CHANGE chunmsg_id chunmsg_id BIGINT(20) NOT NULL AUTO_INCREMENT;"
  end
end
