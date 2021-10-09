# frozen_string_literal: true

class Api::V1::EventsController < ApiController
  def create
    @project = Project.find_by(api_key: params[:project_id])
    if @project
      Events::CreateJob.perform_later(permited_params)
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def permited_params
    params
      .permit(
        :project_id,
        :title,
        :message,
        :created_at,
        :framework,
        :environment,
        :url,
        :ip_address,
        :http_method,
        headers: {},
        params: {},
        server_data: {},
        person_data: {},
        background_data: {},
        route_params: {},
        backtrace: [:code, :lineno, :method, :filename, { context: { pre: [], post: [] } }]
      )
  end
end
