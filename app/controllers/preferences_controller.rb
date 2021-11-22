class PreferencesController < ApplicationController
  def edit
    @project = Project.find(params[:project_id])
    authorize(@project)
    @project_user = @project.project_users.find_by(user: current_user)
  end

  def update
    @project = Project.find(params[:project_id])
    @project_user = @project.project_users.find_by(user: current_user)
    authorize(@project)
    redirect_to project_preferences_path(@project) unless @project_user.update(project_user_params)
    flash.now[:notice] = 'Success'
  end

  private

  def project_user_params
    params.require(:project_user).permit(:notify)
  end
end
