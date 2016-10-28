json.extract! report, :id, :result, :comment,:created_at, :updated_at
json.url report_url(report, format: :json)