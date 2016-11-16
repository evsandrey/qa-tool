json.extract! test_case, :id, :name, :description, :custom_params, :created_at, :updated_at
json.url test_case_url(test_case, format: :json)