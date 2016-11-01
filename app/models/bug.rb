class Bug
  include Mongoid::Document
  field :external_id, type: String
  field :priority, type: String
  field :summary, type: String
  field :description, type: String
end
