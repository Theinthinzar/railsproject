require 'composite_primary_keys'
class MChannel < ApplicationRecord
    
    self.primary_keys = :workspace_id, :user_id,:channel_id
    validates :channel_name,  presence: true, length: { maximum: 50 }
end
