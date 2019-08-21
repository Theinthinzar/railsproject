class CreateTChannelMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :t_channel_messages, id: false, primary_key: :chmsg_id do |t|
      t.primary_key :chmsg_id
      t.integer :chsender_id
      t.integer :channel_id
      t.string :chmessage
      t.timestamps
    end
  end
end
