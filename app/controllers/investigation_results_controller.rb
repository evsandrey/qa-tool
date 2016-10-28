class InvestigationResultsController < ApplicationController
  before_action :set_investigation_result, only: [:show, :edit, :update, :destroy]

  # GET /investigation_results
  # GET /investigation_results.json
  def index
    @investigation_results = InvestigationResult.all
  end

  # GET /investigation_results/1
  # GET /investigation_results/1.json
  def show
  end

  # GET /investigation_results/new
  def new
    @investigation_result = InvestigationResult.new
  end

  # GET /investigation_results/1/edit
  def edit
  end

  # POST /investigation_results
  # POST /investigation_results.json
  def create
    @investigation_result = InvestigationResult.new(investigation_result_params)

    respond_to do |format|
      if @investigation_result.save
        format.html { redirect_to @investigation_result, notice: 'Investigation result was successfully created.' }
        format.json { render :show, status: :created, location: @investigation_result }
      else
        format.html { render :new }
        format.json { render json: @investigation_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investigation_results/1
  # PATCH/PUT /investigation_results/1.json
  def update
    respond_to do |format|
      if @investigation_result.update(investigation_result_params)
        format.html { redirect_to @investigation_result, notice: 'Investigation result was successfully updated.' }
        format.json { render :show, status: :ok, location: @investigation_result }
      else
        format.html { render :edit }
        format.json { render json: @investigation_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investigation_results/1
  # DELETE /investigation_results/1.json
  def destroy
    @investigation_result.destroy
    respond_to do |format|
      format.html { redirect_to investigation_results_url, notice: 'Investigation result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investigation_result
      @investigation_result = InvestigationResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def investigation_result_params
      params.require(:investigation_result).permit(:name, :code, :description)
    end
end
