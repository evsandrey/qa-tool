class Example
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :bool, type: Mongoid::Boolean
end
