class ApixuApi
  def self.weather_in(city)
    url = "https://api.apixu.com/v1/current.json?key=#{key}&q=#{city}"
    response = HTTParty.get url
    response.parsed_response['current']
  end

  def self.key
    # raise "APIXU_APIKEY env variable not defined" if ENV['APIXU_APIKEY'].nil?
    # ENV['APIXU_APIKEY']
    "60657800434b4acdac9201524180810"
  end
end

