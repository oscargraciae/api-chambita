# == Schema Information
#
# Table name: request_statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe RequestStatus, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
