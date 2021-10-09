class AssigneesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @assignees = ProjectUser.includes(:user)
                            .where(project_id: params[:project_id])
                            .where.not(user_id: params[:assignee_id])
  end
end
