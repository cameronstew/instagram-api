class InstagramFetcher
  def initialize
      @connection = Faraday.new(:url => "https://api.instagram.com") do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def authenticate(code)
      response = @connection.post "/oauth/access_token", { client_id: 'aadaebcf044f4c9082dc0cfbbdeecf8b', client_secret: '28bff5820b6049628cf04d30296b59f4', grant_type: 'authorization_code', redirect_uri: 'http://localhost:3013/auth/instagram/callback', code: code }
      JSON.parse(response.body)["access_token"]
    end

    def get_my_feed(access_token)
      response = @connection.get "/v1/users/self/feed", {access_token: access_token}
      JSON.parse(response.body)["data"]
    end

    def get_user_feed(access_token, user_id)
      response = @connection.get "/v1/users/#{user_id}/media/recent", {access_token: access_token}
      JSON.parse(response.body)["data"]
    end
end
