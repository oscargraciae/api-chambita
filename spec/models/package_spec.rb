# == Schema Information
#
# Table name: packages
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  price        :decimal(, )
#  unit_type_id :integer
#  unit_max     :integer
#  service_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_principal :boolean          default(FALSE)
#  active       :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe Package, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
