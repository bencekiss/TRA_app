class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def receive
    # find the last message sent to the number
    @relevant_message = Message.where("to_number = ? AND status = ?", params[:From], "delivered").order("created_at DESC").first

    if @relevant_message
      @schedule = Schedule.find(@relevant_message.schedule_id)
      Message.receive_message(params, @relevant_message, @schedule)
      head :ok, content_type: "text/html"
    else
      @message = Message.where("to_number = ?", params[:From]).order("created_at DESC").first
      Message.create({
          body: params[:Body],
          to_number: params[:To],
          from_number: params[:From],
          status: 'received',
          schedule_id: @message.schedule_id
      })
      # alert("wrong reception!!")
    end
  end

  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    @account = Account.find(params[:account_id])
    @schedule = Schedule.find(params[:id])
    @incoming_messages = Message.where("schedule_id = ? AND status = ?", @schedule.id, "received")
    @notyet_messages = Message.where("schedule_id = ? AND status = ?", @schedule.id, "delivered")
    @answered_messages = Message.where("schedule_id = ? AND status = ?", @schedule.id, "replied")
    @not_messages = Message.where("schedule_id = ? AND status = ?", @schedule.id, "no_reply")

  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.account_id = params[:account_id]

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to account_schedule_path(params[:account_id], @schedule.id), notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def perform
    Schedule.send_reminders
    Schedule.send_primary_rescue
    Schedule.send_secondary_message
    Schedule.send_secondary_rescue
    Schedule.send_emergency_message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:schedule_time, :account_id, :id)
    end
end
