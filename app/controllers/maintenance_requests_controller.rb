class MaintenanceRequestsController < ApplicationController
  before_action :set_maintenance_request, only: [:show, :edit, :update, :destroy, :resolve]
  require 'pry'
  # GET /maintenance_requests
  # GET /maintenance_requests.json
  def index
    if current_user
    @maintenance_requests = current_user.maintenance_requests
  elsif current_contractor
    @maintenance_requests = MaintenanceRequest.all
  end
  end

  # GET /maintenance_requests/1
  # GET /maintenance_requests/1.json
  def show
    @yelp = YelpApiAdapter.search(@maintenance_request.category,@maintenance_request.property.zipcode)
  end

  # GET /maintenance_requests/new
  def new
    @maintenance_request = MaintenanceRequest.new
  end

  # GET /maintenance_requests/1/edit
  def edit
  end

  # POST /maintenance_requests
  # POST /maintenance_requests.json
  def create
    @maintenance_request = MaintenanceRequest.new(maintenance_request_params)
    @maintenance_request.user = current_user
    @maintenance_request.resolved = false
    respond_to do |format|
      if @maintenance_request.save
        UserMailer.with(user: @user, maintenance_request: @maintenance_request).maintenance_notification.deliver_now
        UserMailer.with(maintenance_request: @maintenance_request).contractor_maintenance_notification.deliver_now
        message = "New maintenance request for '#{@maintenance_request.property.street_1}' was just created. Qualified contractors now being alerted."
        TwilioTextMessenger.new(message).call
        format.html { redirect_to @maintenance_request, notice: 'Maintenance request was successfully created.' }
        format.json { render :show, status: :created, location: @maintenance_request }
      else
        format.html { render :new }
        format.json { render json: @maintenance_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def resolve
    @maintenance_request
    if @maintenance_request.resolved?
      @maintenance_request.update_attribute(:resolved, false)
    else
      @maintenance_request.update_attribute(:resolved, true)
    end
    respond_to do |format|
        format.html { redirect_to maintenance_requests_url, notice: 'Maintenance request was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance_request }
    end
  end

  # PATCH/PUT /maintenance_requests/1
  # PATCH/PUT /maintenance_requests/1.json
  def update
    respond_to do |format|
      if @maintenance_request.update(maintenance_request_params)
        format.html { redirect_to @maintenance_request, notice: 'Maintenance request was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance_request }
      else
        format.html { render :edit }
        format.json { render json: @maintenance_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_requests/1
  # DELETE /maintenance_requests/1.json
  def destroy
    @maintenance_request.destroy
    respond_to do |format|
      format.html { redirect_to maintenance_requests_url, notice: 'Maintenance request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_request
      @maintenance_request = MaintenanceRequest.find(params[:id])
      if current_user && @maintenance_request[:user_id] == current_user.id
        @maintenance_request
      elsif current_contractor.id && @maintenance_request[:contractor_id] == current_contractor.id
        @maintenance_request
      else
        redirect_to user_path(current_user), notice: 'You can only view your own maintenance requests.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maintenance_request_params
      params.require(:maintenance_request).permit(:category, :description, :title, :property_id, :tenant_id, :user_id, :contractor_id, :resolved)
    end
end
