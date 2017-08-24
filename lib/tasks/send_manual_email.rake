namespace :send_manual_email do
  desc "Envio de correo"
  task :send => :environment do

    require 'sendgrid-ruby'
    include SendGrid
    sg = SendGrid::API.new(api_key: "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")



    # data = JSON.parse('[
    #   {
    #     "email": "example5@example.com",
    #     "first_name": "Pedro",
    #     "last_name": "User"
    #   },
    #   {
    #     "email": "example6@example.com",
    #     "first_name": "Example",
    #     "last_name": "User"
    #   }
    # ]')

    # data =  JSON.parse('')
    # data = << { first_name: "first_name", last_name: "User", email: "example8@example.com", }
    # data = << { first_name: "first_name8", last_name: "User", email: "example9@example.com", }
    # data = << { first_name: "first_name9", last_name: "User", email: "example10@example.com", }

    # data = data.to_json

    User.find_each do |user|
      #data = JSON.parse(user)

      if user.last_name.blank? === false
          last_name = user.last_name.gsub('"','')
      else
        last_name = " "
      end


      data = JSON.parse('[
        {
          "email": "'+user.email+'",
          "first_name": "'+user.first_name.gsub('"','')+'",
          "last_name": "'+last_name+'"
        }
      ]')

      response = sg.client.contactdb.recipients.post(request_body: data)

      obj = JSON.parse(response.body, object_class: OpenStruct)

      obj.persisted_recipients.each do |x|
        list_id = "1792128"
        recipient_id = x
        response = sg.client.contactdb.lists._(list_id).recipients._(recipient_id).post()
      end
    end



  end
end
