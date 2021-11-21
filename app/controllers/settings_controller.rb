class SettingsController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    authorize(@project)
    @owner = @project.project_users.any? { |user| user.user_id == current_user.id && user.owner? }
  end

  def edit
    @project = Project.find(params[:project_id])
    authorize(@project)
    @owner = @project.project_users.any? { |user| user.user_id == current_user.id && user.owner? }
  end

  def update
    project = Project.find(params[:project_id])
    authorize(@project)
    @owner = project.project_users.any? { |user| user.user_id == current_user.id && user.owner? }
    # TODO: notify authorization error
    redirect_to project_members_path(project) unless @owner

    if project.update(project_params)
      redirect_to project_settings_path(project)
    else
      # TODO: notify error
      head :no_content
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
