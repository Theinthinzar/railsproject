class CreateTDirectstars < ActiveRecord::Migration[5.2]
  def change
    create_table :t_directstars, id: false, primary_key: :dstar_id do |t|
      t.primary_key :dstar_id

      t.references :m_user, references: :m_users, null: false
      t.references :t_dirmessage, references: :t_dirmessages, null: false

      t.timestamps
    end
    rename_column :t_directstars, :m_user_id, :star_userid
    add_foreign_key :t_directstars, :m_users, column: "star_userid", primary_key: "user_id"

    rename_column :t_directstars, :t_dirmessage_id, :stardimsg_id
    add_foreign_key :t_directstars, :t_dirmessages, column: "stardimsg_id", primary_key: "dirmsg_id"
  end
end
