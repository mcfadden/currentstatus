json.current_status (@current_status && @current_status.is_up ? "up" : "down")
json.recent_messages @recent_messages, :content, :created_at
json.errors @errors if @errors.present?