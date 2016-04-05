class Message < ActiveRecord::Base
  
  validates :content, presence: true
  
  scope :recent_messages, ->{ order(created_at: :desc).limit(10) }
end
