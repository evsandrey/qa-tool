class Suite
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  slug  :name
  field :description, type: String
  field :custom_params, type: String
  belongs_to :version
  
end
