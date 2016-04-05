class Status < ActiveRecord::Base
  
  validates_inclusion_of :is_up, in: [true, false]
  
  def self.current_status
    self.order(created_at: :desc).first
  end
end
