# == Schema Information
#
# Table name: rating_types
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe RatingType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
