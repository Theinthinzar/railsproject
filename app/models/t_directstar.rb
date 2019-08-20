require 'composite_primary_keys'
class TDirectstar < ApplicationRecord
     self.primary_keys = :dstar_id,:stardimsg_id,:star_userid
end
