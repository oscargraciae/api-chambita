namespace :finish_request do
    desc "Finaliza las solicitudes si despues de 24hrs el cliente no marca como terminado el trabajo"
    task :daily => :environment do
      begin
        puts "Finaliza las solicitudes si despues de 24hrs el cliente no marca como terminado el trabajo"
        requests = RequestService.where(request_status_id: 2, is_finish_supplier: true)
        requests.each do |request|
            effective_date = request.updated_at + 1.minute

            if effective_date < DateTime.now
                request.update(request_status_id: REQUEST_STATUS_FINISH, is_finish_customer: true)
            end
        end
      rescue => ex
        puts ex.message
      end

    end
end
