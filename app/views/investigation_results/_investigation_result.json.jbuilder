json.extract! investigation_result, :id, :name, :code, :description, :created_at, :updated_at
json.url investigation_result_url(investigation_result, format: :json)