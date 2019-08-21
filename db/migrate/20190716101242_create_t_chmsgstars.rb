class CreateTChmsgstars < ActiveRecord::Migration[5.2]
  def change
    create_table :t_chmsgstars, id: false, primary_key: :chstar_id do |t|
      t.primary_key :chstar_id
      t.integer :chmsgstarid
      t.integer :chstar_userid
      t.timestamps
    end
  end
end
