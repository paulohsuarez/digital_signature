class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all.page(params[:page]).order(created_at: :desc)
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @ur = UserRequest.find_by(user_id: current_user.id, request_id: @request)
    if !@ur.nil? && @ur.signed == true 
      @signed = true
    end
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        RequestMailer.with(user: current_user, request: @request).request_email.deliver_now
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Requests/1
  # PATCH/PUT /Requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Requests/1
  # DELETE /Requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sign
    @request = UserRequest.find_by(user_id: current_user.id, request_id: params[:request])
    if !@request.nil? && @request.signed == FALSE
      respond_to do |format|
        Request.sign_pdf(params[:request], current_user)
        format.html { redirect_to requests_url, notice: 'Assinado.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to requests_url, alert: 'Você já assinou ou não faz parte da lista de destinatários.' }
        format.json { head :no_content }
      end
    end
  end

  def refuse
    @request = Request.find(params[:request])
    @request.update(status: "Reprovada")
    respond_to do |format|
      format.html { redirect_to requests_url, alert: 'Documento Recusado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:document, user_ids:[])
    end
end
