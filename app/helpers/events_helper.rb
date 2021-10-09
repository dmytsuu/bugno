module EventsHelper
  DEFAULT_COLOR = 'bg-gray-400'.freeze
  FRAMEWORK_COLORS = {
    'rails' => 'bg-red-500',
    'browser-js' => 'bg-yellow-500'
  }.freeze

  def framework_color_for(event)
    FRAMEWORK_COLORS[event.framework] || DEFAULT_COLOR
  end
end
