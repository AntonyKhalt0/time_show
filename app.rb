class App
  DATE_TIME = { 'year' => Time.now.year, 
                'month' => Time.now.month, 
                'day' => Time.now.day, 
                'hour' => Time.now.hour, 
                'minute' => Time.now.min,
                'second' => Time.now.sec }.freeze

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    path_definition(req, resp)
      
    resp.finish
  end

  private

  def path_definition(req, resp)
    if req.path.match(/time/)
      array_params_create(req, resp)
    else
      resp.status = 404
    end
  end

  def array_params_create(req, resp)
    array_params = req.params['format'].split(/,/)
    valid_date = []
    invalid_date = []
    array_params.each do |time|
      if DATE_TIME.keys.include?time
        valid_date.push("#{DATE_TIME[time]}")
      else
        invalid_date.push(time)
      end
    end
    if invalid_date.any?
      resp.status = 404
      resp.write "Unknown time format #{invalid_date}"
    else
      resp.write valid_date.join("-")
    end
    resp
  end
end
