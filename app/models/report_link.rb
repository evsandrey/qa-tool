class ReportLink
  include Mongoid::Document
  
  field :report_id, type: String
  field :result, type: Mongoid::Boolean
  field :error, type: String
  field :comment, type: String
  field :investigation_result_id , type: String
  field :investigation_result , type: String
  field :suite, type: String
  field :suite_name, type: String
  field :reruns, type: Integer, default: 0
  
  embedded_in :build
  
  def investigated?
    self.investigation_result.nil? ? false : true 
  end

end
