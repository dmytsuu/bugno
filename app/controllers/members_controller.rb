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
      ProjectMemberMailer.invite(member_params[:email], current_user.email, @project.name).deliver_later
      head :no_content
    end
  end

  def destroy
    project = Project.find(params[:project_id])
    authorize(project)
    @owner = project.project_users.any? { |user| user.user_id == current_user.id && user.owner? }
    @project_user = ProjectUser.find(params[:id])
    if @owner && remove_self?(@project_user.user_id) || !@owner && remove_someone?(@project_user.user_id)
      redirect_to project_members_path(project)
    end
    if @project_user.destroy
      respond_to do |format|
        redirect_to projects_path if remove_self?(@project_user.user_id)
        format.turbo_stream
      end
    else
      # TODO: notify project_user errors
      redirect_to project_members_path(project)
    end
  end

  private

  def remove_self?(user_id)
    current_user.id == user_id
  end

  def remove_someone?(user_id)
    !remove_self?(user_id)
  end

  def member_params
    params.require(:project_user).permit(:email)
  end
end
