class Log
  include Mongoid::Document
  include Mongoid::Timestamps
  field :module_name, type: String
  field :level, type: String
  field :message, type: String
  
  paginates_per 300
  
end
