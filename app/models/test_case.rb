class TestCase
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  slug  :name
  field :description, type: String
  field :custom_params, type: String
  
  belongs_to :version
  belongs_to :category
  
  after_save :broadcast
  
  def broadcast
    ActionCable.server.broadcast 'suites_channel', 
      id: self._id,
      name: self.name
  end
  
end
