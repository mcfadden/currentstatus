class Status < ActiveRecord::Base
  
  validates_inclusion_of :is_up, in: [true, false]
  
  def self.current_status
    self.order(created_at: :desc).first
  end
  
  def self.update_current_status(value)
    value.downcase! if value.kind_of?(String)
    if ["up", "down"].include?(value)
      bool_value = ("up" == value)
      if Status.current_status && Status.current_status.is_up? == bool_value
        # If it's Up, and being set to Up, we don't actually need to update
        # the current status
        return Status.current_status
      else
        return Status.create(is_up: bool_value)
      end
    end
    return false
  end
end
