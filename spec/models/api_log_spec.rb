# == Schema Information
#
# Table name: api_logs
#
#  id         :integer          not null, primary key
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  module     :string
#

require 'rails_helper'

RSpec.describe ApiLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
