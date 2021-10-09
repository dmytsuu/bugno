class ProjectMemberMailer < ApplicationMailer
  def invite(email, inviter, project_name)
    @inviter = inviter
    @project_name = project_name
    mail(to: email, subject: 'Project inviations on Bugno.io')
  end
end
