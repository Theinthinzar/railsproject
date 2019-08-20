require 'composite_primary_keys'
class MWorkspace < ApplicationRecord
   
    self.primary_keys = :workspace_id, :user_id
    validates :workspace_name,  presence: true, length: { maximum: 50 }
end
