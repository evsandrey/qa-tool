class Bug
  include Mongoid::Document
  include Mongoid::Timestamps
  field :external_id, type: String
  field :summary, type: String
  field :external_link, type: String
  field :status, type: String
end
