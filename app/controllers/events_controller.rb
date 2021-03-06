class EventsController < ApplicationController
  before_action :set_event, except: [:index, :new, :create, :latest, :bulk_update]
  before_action :authenticate_user!, except: [:index]

  # GET /events
  # GET /events.json
  def index
    category = Category.find_by(name: params[:category]) if params[:category]

    @events = if params[:keyword]
                Event.where("name LIKE ?", "%#{params[:keyword]}%")
              elsif category
                category.events
              else
                Event.all
              end

    if params[:id] && current_user
      @event = current_user.events.find_by(id: params[:id])
      unless @event
        flash[:alert] = "Something went wrong!"
        redirect_to events_path
      end
    else
      @event = Event.new
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def latest
    @events = Event.latest(5) 
  end

  def bulk_update
    events = Event.where(id: params[:ids])

    if params[:commit] == 'PUBLIC'
      events.update_all(is_public: true)
    elsif params[:commit] == 'UNPUBLIC'
      events.update_all(is_public: false)
    else
      events.destroy_all
    end  

    redirect_to :back
  end

  def dashboard 
  end

  def toggle_public
    @event.toggle!(:is_public)
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(
        :name, 
        :descrption, 
        :is_public, 
        :capacity, 
        :category_id,
        group_ids: []
        )
    end
end
