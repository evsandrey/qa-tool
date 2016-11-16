class Version
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  slug :name
  
  field :description, type: String
  field :vcs, type: String
  
  belongs_to :product, inverse_of: :version
  has_many :builds, dependent: :destroy
  has_many :test_cases, dependent: :destroy
  
  def to_param
    slug
  end
  
end
