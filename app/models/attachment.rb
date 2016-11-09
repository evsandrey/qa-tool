class Attachment
  include Mongoid::Document
  include Mongoid::Paperclip
  
  field :name, type: String
  
  embedded_in :report
  has_mongoid_attached_file :file
  
  validates_attachment_content_type :file, 
                                    :content_type => /^(image|text)\/(plain|png|gif|jpeg)/,
                                    :message => 'only (png/gif/jpeg) images'
end
