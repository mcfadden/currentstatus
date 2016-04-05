class Status < ActiveRecord::Base
  
  validates_inclusion_of :is_up, in: [true, false]
end
