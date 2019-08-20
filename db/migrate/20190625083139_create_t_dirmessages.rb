class CreateTDirmessages < ActiveRecord::Migration[5.2]
  def change
    create_table :t_dirmessages, id: false, primary_key: :dirmsg_id do |t|
      t.primary_key :dirmsg_id
      t.integer :sender_user_id
      t.integer :receiver_user_id
      t.string :dir_message
      t.boolean :is_read

      t.timestamps
    end
  end
end
