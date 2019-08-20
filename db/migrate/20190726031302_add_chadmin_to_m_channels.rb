class AddChadminToMChannels < ActiveRecord::Migration[5.2]
  def change
    add_column :m_channels, :chadmin, :boolean
  end
end
