json.extract! log, :id, :module, :level, :message, :created_at, :updated_at
json.url log_url(log, format: :json)