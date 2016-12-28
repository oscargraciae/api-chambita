namespace :cancel_request do
    desc "Cancela los servicios que no se han aceptado o cancelado en 24 horas depues de la solicitud"
    task :daily => :environment do
        begin
          requests = RequestService.where(request_status_id: 1)
          requests.each do |request|
              effective_date = request.created_at + 24.hours
              if effective_date < DateTime.now.to_date
                  request.update(request_status_id: REQUEST_STATUS_CANCELED)
              end
          end
        rescue => ex
          puts ex.message
        end
    end
end
