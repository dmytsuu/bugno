# frozen_string_literal: true

class EventCollectionsController < ApplicationController
  def destroy
    project = Project.find(collection_params[:id])
    authorize(project)
    project.events.where(status: collection_params[:status]).delete_all
    project.broadcast_replace_to project,
                                 target: "#{collection_params[:status]}_events",
                                 partial: 'projects/events_collection',
                                 locals: { project_id: project.id, status: collection_params[:status] }
    head :no_content
  end

  def collection_params
    params.permit(:id, :status)
  end
end
