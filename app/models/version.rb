class Version
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Paperclip
  
  field :name, type: String
  slug :name
  
  field :build_name_mutator, type: String
  field :description, type: String
  field :vcs, type: String
  
  belongs_to :product, inverse_of: :version
  has_many :builds, dependent: :destroy
  has_many :test_cases, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :hosts, dependent: :destroy
  has_many :reports, dependent: :destroy
  
  has_mongoid_attached_file :tab_icon
  validates_attachment_content_type :tab_icon, 
                                    :content_type => /^image\/(x-icon)/,
                                    :message => 'only .ico images'
  
  
  
  
  after_create :create_defaults
  
  def create_defaults
    category = Category.new
    category.name = "Default"
    category.description = "Default category"
    category.version = self
    category.save
  end
  
  def to_param
    slug
  end
  
end
