class InstagramFetcher
  def initialize
      @connection = Faraday.new(:url => "https://api.instagram.com") do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end



    def instagram
      response = @connection.get "/v1/media/popular", { client_id: ENV['CLIENT_ID'] }
      JSON.parse(response.body)["data"]
    end

    # def look_up(username)
    #   response = @connection.get "/v1/users/search?q='#{username}'&access_token=ACCESS-TOKEN"
    #
    # end

end
