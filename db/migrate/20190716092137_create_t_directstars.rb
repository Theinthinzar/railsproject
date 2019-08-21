class CreateTDirectstars < ActiveRecord::Migration[5.2]
  def change
    create_table :t_directstars, id: false, primary_key: :dstar_id do |t|
      t.primary_key :dstar_id
      t.integer :star_userid
      t.integer :stardimsg_id

      t.timestamps
    end
  end
end
