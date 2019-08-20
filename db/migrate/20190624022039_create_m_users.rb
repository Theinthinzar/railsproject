class CreateMUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :m_users, id: false, primary_key: :user_id do |t|
      t.primary_key :user_id
      t.string :user_name
      t.string :user_email

      t.timestamps
    end
  end
end
