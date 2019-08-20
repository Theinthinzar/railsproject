require 'composite_primary_keys'
class TChmsgstar < ApplicationRecord
     self.primary_keys = :chstar_id,:chmsgstarid,:chstar_userid
end
