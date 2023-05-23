# frozen_string_literal: true

class GptsController < ApplicationController
  GPT_REQUEST_MODEL = 'gpt-3.5-turbo'

  def show
    @event = Event.find(params[:event_id])
    @event = @event.parent if @event.occurrence?
    @answer = if @event.gpt_answer
                @event.gpt_answer
              else
                @event.update(gpt_answer: gpt_answer)
                gpt_answer
              end
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def gpt_answer
    @gpt_answer ||= begin
      question = [
        "What is #{@event.title} ruby exception?.",
        "Here is exception message: #{@event.message}.",
        'What does this mean?'
      ].join
      response = client.chat(
        parameters: {
          model: GPT_REQUEST_MODEL,
          messages: [{ role: 'user', content: question }]
        }
      )
      response.dig('choices', 0, 'message', 'content')
    end
  end
end
