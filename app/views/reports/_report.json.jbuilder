json.extract! report, :id, :name, :result, :comment, :additional_params_id, :created_at, :updated_at
json.url report_url(report, format: :json)