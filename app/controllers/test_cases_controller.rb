class TestCasesController < ApplicationController
  before_action :set_test_case, only: [:show, :edit, :update, :destroy]
  before_action :set_product
  before_action :set_version
  
  
  # GET /test_cases
  # GET /test_cases.json
  def index
    @test_cases = TestCase.where(version_id: @version._id).order(name: :asc)
    @title=@version.name+' test cases'
  end

  # GET /test_cases/1
  # GET /test_cases/1.json
  def show
    @title = @test_case.name
  end

  # GET /test_cases/new
  def new
    @test_case = TestCase.new
    @title='Adding new test case'
  end

  # GET /test_cases/1/edit
  def edit
    @title='Editing: '+@test_case.name
  end

  # POST /test_cases
  # POST /test_cases.json
  def create
    @test_case = TestCase.new(test_case_params)

    respond_to do |format|
      if @test_case.save
        format.html { redirect_to product_version_test_case_path(@product,@version,@test_case), notice: 'TestCase was successfully created.' }
        format.json { render :show, status: :created, location: @test_case }
      else
        format.html { render :new }
        format.json { render json: @test_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_cases/1
  # PATCH/PUT /test_cases/1.json
  def update
    respond_to do |format|
      if @test_case.update(test_case_params)
        format.html { redirect_to product_version_test_case_path(@product,@version,@test_case) , notice: 'TestCase was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_case }
      else
        format.html { render :edit }
        format.json { render json: @test_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_cases/1
  # DELETE /test_cases/1.json
  def destroy
    @test_case.destroy
    respond_to do |format|
      format.html { redirect_to product_version_test_cases_path(@product,@version), notice: 'TestCase was successfully destroyed.' }
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
    def set_test_case
      @test_case = TestCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_case_params
      params.require(:test_case).permit(:name, :description, :custom_params, :version_id, :category_id)
    end
end
