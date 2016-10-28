class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy ]
  respond_to :html, :js, :json
  
  layout false, :except => :edit
  
  skip_before_filter :verify_authenticity_token, :only => [:report_end]
  
  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end
  
  def investigation_update 
    @report=Report.find(params['report']['report_id'])
    @investigation_status = InvestigationResult.find(params['report']['investigation_result_id'])
    @report.comment = params['report']['comment']
    @report.investigation_result = @investigation_status
    @report.save
  end
  
  def investigation_form 
    @report = Report.find(params[:id])
    render :partial => '/reports/investigation_form'
  end
  
  
  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report_end
    @report =  Report.new()
    @report.version = Version.find_by(name: params["version"])
    @report.product = Product.find_by(name: params["product"])
    @report.build = Build.find_by(name: params["build"])
    @report.suite = Suite.find_by(name: params["suite"])
    @report.result  = (params["result"] == 'passed')
    @report.error = params["error"]
    @report.custom_params = params["custom_params"]
    p @report.to_json
    if @report.save 
        format.json { render :show, status: :created, location: @report }
      else
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:name, :suite, :error, :screenshot, :result, :comment, :custom_params)
    end
end
