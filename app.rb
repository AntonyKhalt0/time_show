class App
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    resp.write "#{req.path}\n"

    resp.finish
  end
end
