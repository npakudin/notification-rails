require "uri"
require "net/http"
require "net/https"

module TabletsHelper

  API_KEY = "AIzaSyAL8AoMcMR_fLZeMkFaEAtwOYfvUoOWIG0"

  def send_notification_to_tablet(customer_first_name)
    params =
      {
        data: {
          message: customer_first_name,
        },
        to: "/topics/global",
      }

    url = URI.parse('https://android.googleapis.com/gcm/send')
    req = Net::HTTP::Post.new(url.path)
    #req.form_data = params
    req.body = params.to_json
    req.content_type = "application/json"
    req['Authorization'] = "key=#{API_KEY}"
    req['Content-Type'] = "application/json"
    #req.basic_auth url.user, url.password if url.user
    con = Net::HTTP.new(url.host, url.port)
    con.use_ssl = true
    con.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
    con.start do |http|
      @resp = http.request(req)
      w = 1
    end
  end
end
