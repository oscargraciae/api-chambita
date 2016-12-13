# == Schema Information
#
# Table name: unit_types
#
#  id            :integer          not null, primary key
#  description   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  singular_name :string
#

require 'rails_helper'

RSpec.describe UnitType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
