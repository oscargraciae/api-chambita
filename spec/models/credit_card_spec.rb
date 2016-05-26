# == Schema Information
#
# Table name: credit_cards
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  token      :string
#  last4      :string
#  brand      :string
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
