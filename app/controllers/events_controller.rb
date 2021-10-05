class EventsController < ApplicationController
  def index
    @events = Event
              .where(parent_id: nil, status: params[:status], project_id: params[:project_id])
              .order(Arel.sql('COALESCE(last_occurrence_at, created_at) DESC'))
              .page(params[:page])
    @next_page = @events.next_page
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(params[:event].present? ? event_params : self_assign_params)
      respond_to do |format|
        format.turbo_stream {}
      end
    else
      render project_path(@event.project_id)
    end
  end

  private

  def self_assign_params
    @event.user_id ? { user_id: nil } : { user_id: current_user.id }
  end

  def event_params
    params.require(:event).permit(:user_id, :status)
  end
end
