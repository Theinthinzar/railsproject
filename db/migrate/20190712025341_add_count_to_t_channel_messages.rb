class AddCountToTChannelMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :t_channel_messages, :count, :integer
  end
end
