require "uri"
require "net/http"
require "net/https"

module TabletsHelper

  API_KEY = "AIzaSyAL8AoMcMR_fLZeMkFaEAtwOYfvUoOWIG0"

  def send_notification_to_tablet(tablet, message_uuid, payload)
    params =
      {
        data: {
          message_uuid: message_uuid,
          payload: payload,
        },
        #to: "/topics/global",
        to: tablet.token,
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

      Message.create!(
        tablet_id: tablet.id,
        uuid: message_uuid,
        payload: payload,
        gcm_response: @resp.body,
        gcm_response_code: @resp.code,
        accept_status: Message::ACCEPT_STATUS_NONE,
      )
    end
  end
end
