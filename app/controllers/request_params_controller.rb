class RequestParamsController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    authorize(@event.project)
    @request_params = [{ name: 'Headers', data: @event.headers },
                       { name: 'Params', data: @event.params },
                       { name: 'User', data: @event.person_data }]
                       .reject { |item| item[:data].blank? }
  end
end
