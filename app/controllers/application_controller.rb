class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def authorize(project)
    authorized = project.project_users.any? { |user| user.user_id == current_user.id }
    redirect_to projects_path unless authorized
  end
end
