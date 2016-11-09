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
  
  after_create :broadcast
  
  
  def broadcast
    p "Build created"
    ActionCable.server.broadcast 'builds_channel', 
      id: self._id,
      name: self.name
  end
  
end
