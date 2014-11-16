class Api::V1::EventsController < ApplicationController
  before_action :set_api_v1_event, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/events
  # GET /api/v1/events.json
  def index
    @api_v1_events = Api::V1::Event.all
  end

  # GET /api/v1/events/1
  # GET /api/v1/events/1.json
  def show
  end

  # GET /api/v1/events/new
  def new
    @api_v1_event = Api::V1::Event.new
  end

  # GET /api/v1/events/1/edit
  def edit
  end

  # POST /api/v1/events
  # POST /api/v1/events.json
  def create
    @api_v1_event = Api::V1::Event.new(api_v1_event_params)

    respond_to do |format|
      if @api_v1_event.save
        format.html { redirect_to @api_v1_event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @api_v1_event }
      else
        format.html { render :new }
        format.json { render json: @api_v1_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/events/1
  # PATCH/PUT /api/v1/events/1.json
  def update
    respond_to do |format|
      if @api_v1_event.update(api_v1_event_params)
        format.html { redirect_to @api_v1_event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_v1_event }
      else
        format.html { render :edit }
        format.json { render json: @api_v1_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/events/1
  # DELETE /api/v1/events/1.json
  def destroy
    @api_v1_event.destroy
    respond_to do |format|
      format.html { redirect_to api_v1_events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_event
      @api_v1_event = Api::V1::Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_event_params
      params.require(:api_v1_event).permit(:title, :desc, :location, :url, :image-url, :start_time, :end_time)
    end
end
