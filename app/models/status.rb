class Status < ActiveRecord::Base
  
  validates_inclusion_of :is_up, in: [true, false]
  
  def self.current_status
    self.order(created_at: :desc).first
  end
  
  def self.update_current_status(value)
    clean_value = if value.kind_of?(FalseClass) || value.kind_of?(TrueClass)
      value
    elsif value.kind_of? String
      case value.downcase
      when "up"
        true
      when "down"
        false
      end
    end
    unless clean_value.nil?
      if Status.current_status && Status.current_status.is_up? == clean_value
        Status.current_status
      else
        Status.create(is_up: clean_value)
      end
    else
      return false
    end
  end
end
