# frozen_string_literal: true

class CitizenService < BaseService
  attr_accessor :cid

  def initialize(cid)
    @cid = cid
    super({})
  end

  def run
    fetch_citizen_detail
  end

  private

  def access_token
    Rails.cache.fetch([self, :access_token], expires_in: 1.hour) do
      resp = connection.post('/token') do |req|
        req.params['grant_type'] = 'client_credentials'
        req.body = { client_id: ENV['CITIZEN_CLIENT_KEY'], client_secret: ENV['CITIZEN_CLIENT_SECRET'] }
      end
      JSON.parse(resp.env.response_body)['access_token']
    end
  rescue Faraday::ConnectionFailed => e
    puts e
    422
  end

  def fetch_citizen_detail
    resp = connection.get("/dcrc_citizen_details_api/1.0.0/citizendetails/#{cid}") do |req|
      req.headers['Authorization'] = "Bearer #{access_token}"
    end
    res = ::HashWithIndifferentAccess.new(JSON.parse(resp.env.response_body))
    res&.dig(:citizenDetailsResponse, :citizenDetail, 0)
  rescue Faraday::ConnectionFailed => e
    puts e
    422
  end

  def connection
    @connection ||= Faraday.new(url: ENV['CITIZEN_BASE_URL'], ssl: { verify: false }) do |conn|
      conn.request :multipart
      conn.request :url_encoded
      conn.adapter :net_http
    end
  end
end
