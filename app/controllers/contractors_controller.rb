class ContractorsController < ApplicationController
  before_action :set_contractor, only: [:show, :edit, :update, :destroy, :stripe_callback]

  # GET /contractors
  # GET /contractors.json
  def index
    @contractors = current_contractor
  end

  # GET /contractors/1
  # GET /contractors/1.json
  def show
    @account = Stripe::Account.retrieve("#{@contractor.stripe_uid.to_s}") if @contractor.stripe_uid.present?
    @balance = Stripe::Balance.retrieve() if @contractor.stripe_uid.present?
  end

  # GET /contractors/new
  def new
    @contractor = Contractor.new
  end

  # GET /contractors/1/edit
  def edit
  end

  # POST /contractors
  # POST /contractors.json
  def create
    params
    @contractor = Contractor.new(contractor_params)

    respond_to do |format|
      if @contractor.save
        session[:contractor_id] = @contractor.id
        format.html { redirect_to @contractor, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @contractor }
      else
        format.html { render :new }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contractors/1
  # PATCH/PUT /contractors/1.json
  def update
    respond_to do |format|
      if @contractor.update(contractor_params)
        format.html { redirect_to @contractor, notice: 'Contractor was successfully updated.' }
        format.json { render :show, status: :ok, location: @contractor }
      else
        format.html { render :edit }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contractors/1
  # DELETE /contractors/1.json
  def destroy
    @contractor.destroy
    respond_to do |format|
      format.html { redirect_to contractors_url, notice: 'Contractor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def stripe_callback
            options = {
              site: 'https://connect.stripe.com',
              authorize_url: '/oauth/authorize',
              token_url: '/oauth/token'
            }
            code = params[:code]
            client = OAuth2::Client.new(Rails.application.credentials.config[:STRIPE_CONNECT_CLIENT_ID], Rails.application.credentials.config[:STRIPE_SECRET_KEY], options)
            @resp = client.auth_code.get_token(code, :params => {:scope => 'read_write'})
            @access_token = @resp.token
            binding.pry
            @contractor.update!(stripe_uid: @resp.params["stripe_user_id"]) if @resp
            flash[:notice] = "Your account has been successfully created and is ready to process payments!"
   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contractor
      @contractor = Contractor.find(session[:contractor_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contractor_params
      params.require(:contractor).permit(:first_name, :last_name, :company, :email, :password, :password_confirmation, :maintenance_request_id, :phone, :occupation, :stripe_uid)
    end
end
