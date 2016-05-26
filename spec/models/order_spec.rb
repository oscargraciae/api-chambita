# == Schema Information
#
# Table name: orders
#
#  id                 :integer          not null, primary key
#  request_service_id :integer
#  order_status_id    :integer
#  service_price      :decimal(, )
#  fee                :decimal(, )
#  total              :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
