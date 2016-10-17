class Log
  include Mongoid::Document
  include Mongoid::Timestamps
  field :module_name, type: String
  field :level, type: String
  field :message, type: String
  field :ip_address, type: String
  
  belongs_to :user
  
  paginates_per 300
  
  def get_color
    case level
      when "A"
        "table-active"
      when ""
        "table-success"
      when "D"
        "table-warning"
      when "W"
        "table-danger"
      when "E"  
        "table-info"
      end
  end  
  
end
