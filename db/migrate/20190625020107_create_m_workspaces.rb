class CreateMWorkspaces < ActiveRecord::Migration[5.2]
  def change
    create_table :m_workspaces, id: false do |t|
      t.integer :workspace_id
      t.integer :user_id
      t.string :workspace_name
      t.boolean :admin

      t.timestamps
    end
    execute "ALTER TABLE m_workspaces ADD PRIMARY KEY (workspace_id,user_id);"
    execute "ALTER TABLE m_workspaces CHANGE workspace_id workspace_id BIGINT(20) NOT NULL AUTO_INCREMENT;"
  end
end
