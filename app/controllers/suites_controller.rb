class SuitesController < ApplicationController
  before_action :set_suite, only: [:show, :edit, :update, :destroy]
  before_action :set_product
  before_action :set_version
  
  
  # GET /suites
  # GET /suites.json
  def index
    @suites = Suite.where(version: @version)
  end

  # GET /suites/1
  # GET /suites/1.json
  def show
  end

  # GET /suites/new
  def new
    @suite = Suite.new
  end

  # GET /suites/1/edit
  def edit
  end

  # POST /suites
  # POST /suites.json
  def create
    @suite = Suite.new(suite_params)

    respond_to do |format|
      if @suite.save
        format.html { redirect_to product_version_suite_path(@product,@version,@suite), notice: 'Suite was successfully created.' }
        format.json { render :show, status: :created, location: @suite }
      else
        format.html { render :new }
        format.json { render json: @suite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suites/1
  # PATCH/PUT /suites/1.json
  def update
    respond_to do |format|
      if @suite.update(suite_params)
        format.html { redirect_to product_version_suite_path(@product,@version,@suite) , notice: 'Suite was successfully updated.' }
        format.json { render :show, status: :ok, location: @suite }
      else
        format.html { render :edit }
        format.json { render json: @suite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suites/1
  # DELETE /suites/1.json
  def destroy
    @suite.destroy
    respond_to do |format|
      format.html { redirect_to product_version_suites_path(@product,@version), notice: 'Suite was successfully destroyed.' }
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
    def set_suite
      @suite = Suite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suite_params
      params.require(:suite).permit(:name, :description, :custom_params, :version_id)
    end
end
