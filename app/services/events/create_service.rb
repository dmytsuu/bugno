# frozen_string_literal: true

class Events::CreateService < ApplicationService
  def call
    return event unless project

    # ::Events::ResolveSourceCodeService.call(event: event, trace: event.backtrace[0]) if resolve_source?
    event.save
    update_parrent if event.persisted? && event.occurrence?
    event
  end

  private

  def update_parrent
    parent.update(last_occurrence_at: Time.now)
    parent.active! if parent.resolved?
  end

  def resolve_source?
    event.framework == Event::BROWSER_JS && event.backtrace.present?
  end

  def project
    @project ||= Project.find_by(api_key: @params[:project_id])
  end

  def event
    @event ||= Event.new(event_attributes)
  end

  def event_attributes
    project ? built_attributes : @params
  end

  def parent
    @parent ||= Event.find(built_attributes[:parent_id])
  end

  def built_attributes
    @built_attributes ||= Events::BuildAttributesService.call(params: @params, project: project)
  end
end
