class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Paperclip
  
  field :name, type: String
  slug  :name
  
  field :description, type: String
  
  has_many :versions, inverse_of: :product, dependent: :destroy
  
  has_mongoid_attached_file :logo
  validates_attachment_content_type :logo, 
                                    :content_type => /^image\/(png|gif|jpeg)/,
                                    :message => 'only (png/gif/jpeg) images'

end
