class InvestigationResult
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :code, type: String
  field :description, type: String
end
