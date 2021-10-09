class Chunk
  attr_reader :code, :lineno, :method, :context, :filename

  def initialize(data = {})
    @code = data['code']
    @lineno = data['lineno']
    @method = data['method']
    @context = data['context']
    @filename = data['filename']
    @project_error = data['project_error']
  end

  def project?
    @project_error
  end

  def pre_lines
    lines = @context&.dig('pre') || []
    lines.map.with_index do |line, index|
      { lineno: @lineno - lines.length + index, code: line }
    end
  end

  def post_lines
    lines = @context&.dig('post') || []
    lines.map.with_index(1) do |line, index|
      { lineno: @lineno + index, code: line }
    end
  end

  def lines
    pre_lines + [{ lineno: @lineno, code: @code, main: true }] + post_lines
  end
end
