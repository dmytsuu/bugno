# frozen_string_literal: true

class Events::NotifyService < ApplicationService
  FIRST_NOTIFICATION_POINT = 5
  OCCURRENCE_NOTIFICATION_POINTS = [FIRST_NOTIFICATION_POINT, 10, 25, 50, 100, 150, 250, 500, 750, 1000, 2000, 3000,
                                    4000].freeze

  def call
    return unless notify? && notifiable_status?

    EventMailer.send(mailer_action, @event, user_emails).deliver_later
  end

  private

  def mailer_action
    @mailer_action ||= begin
      return :high_frequency if high_frequency?

      @event.parent? ? :exception : :occurrence
    end
  end

  def notify?
    if high_frequency?
      notification_point?(frequency)
    else
      @event.parent? || occurrence_point?
    end
  end

  def notifiable_status?
    !@event.muted? && !@event.parent&.muted?
  end

  def notification_point?(times_occurred)
    OCCURRENCE_NOTIFICATION_POINTS.any? { |point| point == times_occurred }
  end

  def occurrence_point?
    notification_point?(@event.parent.occurrence_count)
  end

  def frequency
    @frequency ||= Event.since(1.minute.ago).where(title: @event.title, project_id: @event.project_id).count
  end

  def high_frequency?
    @high_frequency ||= frequency > FIRST_NOTIFICATION_POINT - 1
  end

  def user_emails
    @user_emails ||= event.project.project_users.joins(:user).where(notify: true).pluck(Arel.sql('users.email'))
  end
end
