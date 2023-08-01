# frozen_string_literal: true

class Events::CreateJob < ApplicationJob
  queue_as :default

  def perform(params)
    @event = Events::CreateService.call(params: params)
    # Events::NotifyService.call(event: @event) if @event.persisted?
  end
end
