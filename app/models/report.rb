class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  field :result, type: Mongoid::Boolean
  field :status, type: String
  field :broken, type: String
  field :error, type: String
  field :total_time, type: String
  field :logs_location, type: String
  field :comment, type: String
  field :custom_params, type: String
  
  has_mongoid_attached_file :screenshot
  validates_attachment_content_type :screenshot, 
                                     :content_type => /^image\/(png|gif|jpeg)/,
                                     :message => 'only (png/gif/jpeg) images'
  
  belongs_to :investigation_result, optional: true
  belongs_to :user, optional: true
  belongs_to :version
  belongs_to :test_case
  belongs_to :build
  belongs_to :host
  
  embeds_many :attachments
  
  paginates_per 100
  
  after_save :link_to_build
  after_create :compare_with_prev_build
  after_save :broadcast
  
  accepts_nested_attributes_for :attachments
  
  def broadcast
    ActionCable.server.broadcast 'reports_channel', 
      id: self._id,
      build: self.build_id,
      test_case: self.test_case_id,
      message: render_icon(self)
  end
  
  def link_to_build
    new = true
    if self.build.report_links.where(test_case: self.test_case_id).last.nil? 
      r_link = ReportLink.new() 
    else 
      r_link = self.build.report_links.where(test_case: self.test_case_id).last
      r_link.reruns += 1 
      new = false
    end
    r_link.report_id = self._id
    r_link.result = self.result
    r_link.url = Rails.application.routes.url_helpers.show_direct_report_path(self)
    r_link.error = self.error
    r_link.comment = self.comment
    r_link.broken = self.broken if !self.broken.blank?
    r_link.total_time = self.total_time if !self.total_time.blank?
    r_link.investigation_result_id = self.investigation_result_id if !self.investigation_result_id.blank?
    r_link.investigation_result = self.investigation_result.code if !self.investigation_result_id.blank?
    r_link.test_case = self.test_case_id
    r_link.test_case_name = self.test_case.name
    
    r_link.host = self.host if !self.host.blank?
    
    new ? self.build.report_links << r_link : r_link.save
    self.build.save

  end
  
  def get_prev_build_last_report
    prev_build = Build.where(:_id.lt => self.build._id).order_by([[:_id, :desc]]).limit(1).first
    if !prev_build.blank?
      prev_report = prev_build.report_links.where(test_case: self.test_case.id).limit(1).first
      if !prev_report.blank?
        prev_report
      else
        nil
      end
    else 
      nil
    end
  end
  
  def investigated?
    self.investigation_result.nil? ? false : true 
  end  
  
  def apply_auto_investigation_rules
    true
  end
  
  def compare_with_prev_build
    prev_report = get_prev_build_last_report
    if !prev_report.nil?
      if prev_report.error == self.error && prev_report.investigated?
        self.investigation_result = InvestigationResult.find(prev_report.investigation_result_id)
        self.comment = prev_report.comment
        self.save
        "Comparsion applied"
      else
        self.apply_auto_investigation_rules
        ""
      end  
    else
      self.apply_auto_investigation_rules
      ""
    end
  end
  
  def render_icon(report) 
      ApplicationController.new.render_to_string(partial: 'reports/icon', locals: {report: report})
  end
  
end
