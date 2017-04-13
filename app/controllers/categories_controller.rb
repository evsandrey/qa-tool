class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  
  before_action :set_product
  before_action :set_version
  
  skip_before_filter :verify_authenticity_token
  
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @product = @category.version.product
  end

  # GET /categories/new
  def new
    @category = Category.new
    @category.version = @version
    @product = @category.version.product
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to product_version_path(@product,@version,@category), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to product_version_category_path(@product,@version,@category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to product_version_categories_path, notice: 'Category was successfully destroyed.' }
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
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description, :version_id)
    end
end
