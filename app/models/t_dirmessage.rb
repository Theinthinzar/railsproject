class TDirmessage < ApplicationRecord
    self.primary_keys = :dirmsg_id
    validates :dir_message,  presence: true, length: { maximum: 250  }
    has_many :m_users
   
end