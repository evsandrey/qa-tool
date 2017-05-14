class ReportLink
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :report_id, type: String
  field :result, type: Mongoid::Boolean
  field :error, type: String
  field :comment, type: String
  field :investigation_result_id , type: String
  field :investigation_result , type: String
  field :test_case, type: String
  field :test_case_name, type: String
  field :reruns, type: Integer, default: 0
  field :broken, type: String
  field :total_time, type: String
  
  belongs_to :host, optional: true
  
  
  embedded_in :build
  
  def investigated?
    self.investigation_result.nil? ? false : true 
  end

end
