class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  field :result, type: Mongoid::Boolean
  field :status, type: String
  field :error, type: String
  field :screenshot, type: String
  field :comment, type: String
  field :custom_params, type: String
  
  # has_mongoid_attached_file :screenshot
  # validates_attachment_content_type :screenshot, 
  #                                   :content_type => /^image\/(png|gif|jpeg)/,
  #                                   :message => 'only (png/gif/jpeg) images'
  
  belongs_to :investigation_result, optional: true
  belongs_to :suite
  belongs_to :build
  
  embeds_many :attachments
  
  after_save :broadcast
  after_save :link_to_build
  
  
  def broadcast
    ActionCable.server.broadcast 'reports_channel', 
      id: self._id,
      build: self.build_id,
      suite: self.suite_id,
      message: render_icon(self)
  end
  
  def link_to_build
    new = true
    if self.build.report_links.where(suite: self.suite_id).last.nil? 
      r_link = ReportLink.new() 
    else 
      r_link = self.build.report_links.where(suite: self.suite_id).last
      r_link.reruns += 1 
      new = false
    end
    r_link.report_id = self._id
    r_link.result = self.result
    r_link.error = self.error
    r_link.comment = self.comment
    r_link.investigation_result = self.investigation_result.code if !self.investigation_result_id.blank?
    r_link.suite = self.suite_id
    r_link.suite_name = self.suite.name
    
    new ? self.build.report_links << r_link : r_link.save
    self.build.save

  end
  
  def render_icon(report) 
      ApplicationController.new.render_to_string(partial: 'reports/icon', locals: {report: report})
  end
  
end
