class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  slug  :name
  
  field :description, type: String
  has_many :versions, inverse_of: :product, dependent: :destroy
end
