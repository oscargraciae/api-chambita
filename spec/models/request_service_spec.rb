# == Schema Information
#
# Table name: request_services
#
#  id                 :integer          not null, primary key
#  message            :text
#  request_date       :date
#  request_time       :time
#  request_status_id  :integer          default(3)
#  service_id         :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  price              :decimal(, )
#  fee                :decimal(, )
#  supplier_id        :integer
#  is_finish_supplier :boolean          default(FALSE)
#  is_finish_customer :boolean          default(FALSE)
#  is_evaluated       :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe RequestService, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
