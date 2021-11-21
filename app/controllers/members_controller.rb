class MembersController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    authorize(@project)
    @members = @project.project_users.includes(:user)
    @owner = @members.any? { |user| user.user_id == current_user.id && user.owner? }
  end

  def new
    @project = Project.find(params[:project_id])
    authorize(@project)
    @member = @project.project_users.new(role: :collaborator)
    @owner = @project.project_users.any? { |user| user.user_id == current_user.id && user.owner? }
  end

  def create
    @project = Project.find(params[:project_id])
    authorize(@project)
    @owner = @project.project_users.any? { |user| user.user_id == current_user.id && user.owner? }
    # TODO: notify authorization error
    redirect_to project_members_path(@project) unless @owner

    user = User.find_by(email: member_params[:email])
    if user
      @project_user = ProjectUser.new(user: user, project: @project, role: :collaborator)
      if @project_user.save
        # TODO: notify success
      else
        # TODO: notify project_user errors
        redirect_to project_members_path(@project)
      end
    else
      # TODO: notify user invited && change to deliver_later
      ProjectMemberMailer.invite(member_params[:email], current_user.email, @project.name).deliver_now
      head :no_content
    end
  end

  def destroy
    project = Project.find(params[:project_id])
    authorize(project)
    @owner = project.project_users.any? { |user| user.user_id == current_user.id && user.owner? }
    # TODO: notify authorization error
    redirect_to project_members_path(project) unless @owner
    @project_user = ProjectUser.find(params[:id])
    if @project_user.destroy
      respond_to do |format|
        format.turbo_stream
      end
    else
      # TODO: notify project_user errors
      redirect_to project_members_path(project)
    end
  end

  private

  def authorize(project)
    authorized = project.project_users.any? { |user| user.user_id == current_user.id }
    redirect_to projects_path unless authorized
  end

  def member_params
    params.require(:project_user).permit(:email)
  end
end
