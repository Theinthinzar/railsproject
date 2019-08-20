class AddDirworkspaceIdToTDirmessages < ActiveRecord::Migration[5.2]
  def change
    add_column :t_dirmessages, :dirworkspace_id, :integer
  end
end
