class FormatTime
  DATE_TIME = { 'year' => Time.now.year, 
              'month' => Time.now.month, 
              'day' => Time.now.day, 
              'hour' => Time.now.hour, 
              'minute' => Time.now.min,
              'second' => Time.now.sec }.freeze

  def initialize(req, resp)
    @req = req
    @resp = resp
    @valid_date = []
    @invalid_date = []
    array_params_create
  end

  def valid?
    @req.path.match(/time/) && @invalid_date.empty?
  end

  def valid_formats
    @resp.write @valid_date.join("-")
  end

  def invalid_formats
    if @invalid_date.any?
      @resp.status = 404
      @resp.write "Unknown time format #{@invalid_date}"
    else
      @resp.status = 404
    end
  end

  private

  def array_params_create
    if self.valid?
      array_params = @req.params['format'].split(/,/)
      array_params.each do |time|
        if DATE_TIME.keys.include?time
          @valid_date.push("#{DATE_TIME[time]}")
        else
          @invalid_date.push(time)
        end
      end
    end
  end
end
