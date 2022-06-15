require_relative 'format_time'

class App
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    response_body(req, resp)
      
    resp.finish
  end

  private

  def response_body(req, resp)
    formatter = FormatTime.new(req, resp)
    if formatter.valid?
      formatter.valid_formats
    else
      formatter.invalid_formats
    end
  end

end
