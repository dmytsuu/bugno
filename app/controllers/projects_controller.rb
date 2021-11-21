class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects
  end

  def new
    @new_project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.project_users.create(user: current_user, role: :owner)
      redirect_to project_settings_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    authorize(@project)
  end

  def destroy
    @project = Project.find(params[:id])
    authorize(@project)
    @project.destroy
    redirect_to projects_path
  end

  private

  def authorize(project)
    authorized = project.project_users.any? { |user| user.user_id == current_user.id }
    redirect_to projects_path unless authorized
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
