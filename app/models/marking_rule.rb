class MarkingRule
  include Mongoid::Document
  field :name, type: String
  field :pattern, type: String
  
  belongs_to :version
  
end
