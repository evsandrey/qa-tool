class MarkingRulesController < ApplicationController
  before_action :set_marking_rule, only: [:show, :edit, :update, :destroy]

  before_action :set_product
  before_action :set_version

  # GET /marking_rules
  # GET /marking_rules.json
  
  def index
    @marking_rules = MarkingRule.where(version_id: @version)
  end

  # GET /marking_rules/1
  # GET /marking_rules/1.json
  def show
  end

  # GET /marking_rules/new
  def new
    @marking_rule = MarkingRule.new
    @marking_rule.version = @version
  end

  # GET /marking_rules/1/edit
  def edit
  end

  # POST /marking_rules
  # POST /marking_rules.json
  def create
    @marking_rule = MarkingRule.new(marking_rule_params)

    respond_to do |format|
      if @marking_rule.save
        format.html { redirect_to product_version_marking_rule_path(@product,@version,@marking_rule), notice: 'Marking rule was successfully created.' }
        format.json { render :show, status: :created, location: @marking_rule }
      else
        format.html { render :new }
        format.json { render json: @marking_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marking_rules/1
  # PATCH/PUT /marking_rules/1.json
  def update
    respond_to do |format|
      if @marking_rule.update(marking_rule_params)
        format.html { redirect_to product_version_marking_rule_path(@product,@version,@marking_rule), notice: 'Marking rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @marking_rule }
      else
        format.html { render :edit }
        format.json { render json: @marking_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marking_rules/1
  # DELETE /marking_rules/1.json
  def destroy
    @marking_rule.destroy
    respond_to do |format|
      format.html { redirect_to marking_rules_url, notice: 'Marking rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_version
      if params[:version_id]
        @version = Version.find(params[:version_id])
      end
    end
    
    def set_product
      if params[:product_id]
        @product = Product.find(params[:product_id])
      end
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_marking_rule
      @marking_rule = MarkingRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marking_rule_params
      params.require(:marking_rule).permit(:name, :pattern, :investigation_result_id, :version_id )
    end
end
