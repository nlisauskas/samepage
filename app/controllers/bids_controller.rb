class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  require 'pry'

  # GET /bids
  # GET /bids.json
  def index
    if current_user
    @bids = current_user.bids
  elsif current_contractor
    @bids = current_contractor.bids
  end
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    binding.pry
    if current_contractor.stripe_uid?
    @bid = Bid.new
    @maintenance_request = MaintenanceRequest.find_by_id(params[:maintenance_request_id])
    else
    redirect_to contractor_path(current_contractor), :notice => "You must connect your account with Stripe prior to placing bids on the platform."
    end
  end

  # GET /bids/1/edit
  def edit
    @maintenance_request = @bid.maintenance_request
    @bid.info_requested = false
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)
    @bid.maintenance_request = MaintenanceRequest.find_by_id(params[:bid][:maintenance_request_id])
    @user = User.find_by_id(@bid.maintenance_request.user_id)
    @bid.contractor = current_contractor
    if @bid.price
      @bid.payout = @bid.price * 0.90
    end
    respond_to do |format|
      if @bid.save
        UserMailer.with(user: @user, bid: @bid, contractor: @bid.contractor).bid_notification.deliver_now
        message = "New bid for your job at #{@bid.maintenance_request.property.street_1} was just created. The initial quote is $#{@bid.price} (subject to change). You can view more details at samepageco.app/maintenance_requests/#{@bid.maintenance_request.id}"
        TwilioTextMessenger.new(message).call
        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @bid }
      else
        flash[:bid_errors] = @bid.errors.full_messages
        @maintenance_request = MaintenanceRequest.find_by_id(params[:bid][:maintenance_request_id])
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        @bid.maintenance_request = MaintenanceRequest.find_by_id(params[:bid][:maintenance_request_id])
        @user = User.find_by_id(@bid.maintenance_request.user_id)
        @bid.contractor = current_contractor
        if @bid.price
          @bid.payout = @bid.price * 0.90
        end
        @bid.save
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        @bid = Bid.new
        @maintenance_request = MaintenanceRequest.find_by_id(params[:maintenance_request_id])
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:price, :payout, :availability, :notes, :maintenance_request_id, :contractor_id, :approved, :info_requested)
    end
end
