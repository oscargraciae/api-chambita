class PurchaseDetail < ApplicationMailer
  default :from => 'Chambita <hello@chambita.mx>'
  layout "send_purchase_detail"
  # send a signup email to the user, pass in the user object that contains the user's email address
  def send_purchase_detail(user, request, service, supplier)

    headers "X-SMTPAPI" => {
      "sub": {
        "%name%" => [user.first_name],
        "%service_name%" => [service.name],
        "%service_date%" => [request.request_date],
        "%service_time%" => [request.request_time],
        "%service_supplier%" => [supplier.first_name],
        "%service_bruto%" => [service.price],
        "%service_comision%" => [request.fee],
        "%service_neto%" => [request.price] + [request.fee]
      },
      "filters": {
        "templates": {
          "settings": {
            "enable": 1,
            "template_id": '22df6bca-f8c3-4e30-a097-34c7c0664c3f'
          }
        }
      }
    }.to_json

    mail( :to => user.email,:subject => 'Tu servicio fue solicitado satisfactoriamente' )
  end
end
  