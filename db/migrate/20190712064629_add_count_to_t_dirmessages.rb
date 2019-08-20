class AddCountToTDirmessages < ActiveRecord::Migration[5.2]
  def change
    add_column :t_dirmessages, :count, :integer
  end
end
