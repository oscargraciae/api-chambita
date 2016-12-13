# == Schema Information
#
# Table name: evaluations
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  service_id     :integer
#  comment        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  supplier_id    :integer
#  subcategory_id :integer
#

require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
