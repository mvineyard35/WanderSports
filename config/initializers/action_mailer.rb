require 'net/http'
require 'uri'
require 'json'

class TrustifiMailer
  def initialize(values)
    @settings = values
  end

  def deliver!(mail)
    uri = URI.parse("https://be.trustifi.com/api/i/v1/email")

    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["X-Trustifi-Api-Key"] = ENV['TRUSTIFI_API_KEY']
    request["X-Trustifi-Secret-Key"] = ENV['TRUSTIFI_SECRET_KEY']

    request.body = {
      "recipients": [{ "email": mail.to.first }],
      "title": mail.subject,
      "html": mail.body.raw_source,
      "from": {
        "name": mail.from.first,
        "email": mail.from.first
      }
    }.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise "Failed to send email: #{response.body}"
    end
  end
end

# ✅ Register the custom delivery method properly
ActionMailer::Base.add_delivery_method :trustifi_mailer, TrustifiMailer

# ✅ Set delivery method
Rails.application.config.action_mailer.delivery_method = :trustifi_mailer
