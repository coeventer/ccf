class EventRegistrationsController < ApplicationController
  # GET /event_registrations/1
  # GET /event_registrations/1.json
  def show
    @event_registration = EventRegistration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_registration }
    end
  end

  # GET /event_registrations/new
  # GET /event_registrations/new.json
  def new
    @event = Event.find(params[:event_id])
    @event_registration = @event.registrations.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /event_registrations/1/edit
  def edit
    @event = Event.find(params[:event_id])
    @event_registration = @event.registrations.find(params[:id])
  end

  # POST /event_registrations
  # POST /event_registrations.json
  def create
    @event = Event.find(params[:event_id])
    @event_registration = @event.registrations.new(params[:event_registration])
    @event_registration.user = current_user

    respond_to do |format|
      if @event_registration.save
        format.html { redirect_to event_path(@event), notice: "You have registered for #{@event.title}." }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /event_registrations/1
  # PUT /event_registrations/1.json
  def update
    @event = Event.find(params[:event_id])
    event_registration = @event.registrations.find(params[:id])

    respond_to do |format|
      if @event_registration.update_attributes(params[:event_registration])
        format.html { redirect_to @event_registration, notice: 'Event registration was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /event_registrations/1
  # DELETE /event_registrations/1.json
  def destroy
    @event = Event.find(params[:event_id])
    event_registration = @event.registrations.find(params[:id])
    event_registration.destroy

    respond_to do |format|
      format.html { redirect_to event_url(@event) }
    end
  end
end
