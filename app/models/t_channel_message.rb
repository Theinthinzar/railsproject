class TChannelMessage < ApplicationRecord
    self.primary_keys = :chmsg_id
    validates :chmessage,  presence: true, length: { maximum: 50 }
    has_many :m_users
end
