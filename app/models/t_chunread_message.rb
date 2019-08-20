require 'composite_primary_keys'
class TChunreadMessage < ApplicationRecord
    self.primary_keys = :chmsg_id,:chuser_id,:chunmsg_id
    
end
