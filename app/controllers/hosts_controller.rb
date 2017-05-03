class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]
  before_action :set_product
  before_action :set_version


  # GET /hosts
  # GET /hosts.json
  def index
    @hosts = Host.where(version_id: @version)
  end
  # GET /hosts/1
  # GET /hosts/1.json
  def show
  end

  # GET /hosts/new
  def new
    @host = Host.new
  end

  # GET /hosts/1/edit
  def edit
  end

  # POST /hosts
  # POST /hosts.json
  def create
    @host = Host.new(host_params)

    respond_to do |format|
      if @host.save
        format.html { redirect_to product_version_host_path(@product,@version,@host), notice: 'Host was successfully created.' }
        format.json { render :show, status: :created, location: @host }
      else
        format.html { render :new }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hosts/1
  # PATCH/PUT /hosts/1.json
  def update
    respond_to do |format|
      if @host.update(host_params)
        format.html { redirect_to product_version_host_path(@product,@version,@host), notice: 'Host was successfully updated.' }
        format.json { render :show, status: :ok, location: @host }
      else
        format.html { render :edit }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    @host.destroy
    respond_to do |format|
      format.html { redirect_to product_version_hosts_path, notice: 'Host was successfully destroyed.' }
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
    def set_host
      @host = Host.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def host_params
      params.require(:host).permit(:name, :description)
    end
end
