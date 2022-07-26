class Api::V1::NotificationsController < ApplicationController
    rescue_from StandardError do |exception|
        trigger_sms_alerts(exception)
    end
    
    def trigger_sms_alerts(e)
        @alert_message = "
          [This is a test] ALERT!
          It appears the server is having issues.
          Exception: #{e}.
          Go to: http://newrelic.com for more details."
        @image_url = 'http://howtodocs.s3.amazonaws.com/new-relic-monitor.png'

        @admin_list = YAML.load_file('config/administrators.yml')
        @admin_list.each do |admin|
            begin
                phone_number = admin['phone_number']
                send_message(phone_number, @alert_message, @image_url)
                flash[:success] = "Exception: #{e}. Administrators will be notified."
            rescue
                flash[:alert] = 'Something when wrong.'
            end
        end
   end

    private
    def send_message(phone_number, alert_message, _image_url)
        @twilio_number = ENV['TWILIO_NUMBER']
        @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

        message = @client.account.messages.create(
            from: @twilio_number,
            to: phone_number,
            body: alert_message,
            # US phone numbers can make use of an image as well.
            # :media_url => image_url
        )
    end
end
