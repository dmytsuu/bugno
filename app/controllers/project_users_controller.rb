class ProjectUsersController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @project_users = ProjectUser.includes(:user)
                                .where(project_id: params[:project_id])
                                .where.not(user_id: params[:assignee_id])
  end
end
