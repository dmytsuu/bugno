class MobileProjectsController < ApplicationController
  def index
    @mobile_projects = current_user.projects
  end
end
