class Build
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  slug  :name
  
  field :description, type: String
  
  belongs_to :version
  has_many :reports
  
  embeds_many :report_links
  
  accepts_nested_attributes_for :report_links
  
end
