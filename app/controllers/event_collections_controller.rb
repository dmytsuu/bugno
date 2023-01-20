class EventCollectionsController < ApplicationController
  def destroy
    project = Project.find(collection_params[:project_id])
    authorize(project)
    project.events.where(status: collection_params[:status]).delete_all
    project.broadcast_remove_to project, target: "#{collection_params[:status]}_events"
    head :no_content
  end

  def collection_params
    params.permit(:project_id, :status)
  end
end
