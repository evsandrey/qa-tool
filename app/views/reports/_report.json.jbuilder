json.extract! report, :id, :result, :created_at, :updated_at
json.url report_url(report, format: :json)