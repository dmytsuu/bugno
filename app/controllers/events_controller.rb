class EventsController < ApplicationController
  def index
    @events = Event
              .includes(:user)
              .where(parent_id: nil, status: params[:status], project_id: params[:project_id])
              .order(Arel.sql('COALESCE(last_occurrence_at, created_at) DESC'))
              .page(params[:page])
    @next_page = @events.next_page
  end

  def show
    @event = Event.includes(:project, :last_occurrence).find(params[:id])
    @project = @event.project
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(params[:event].present? ? event_params : self_assign_params)
      EventMailer.assign(@event, current_user).deliver_later if @event.user_id_previously_changed? && @event.user && @event.user != current_user
      respond_to do |format|
        format.turbo_stream {}
      end
    else
      render project_path(@event.project_id)
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    head :no_content
  end

  private

  def self_assign_params
    @event.user_id ? { user_id: nil } : { user_id: current_user.id }
  end

  def event_params
    params.require(:event).permit(:user_id, :status)
  end
end
