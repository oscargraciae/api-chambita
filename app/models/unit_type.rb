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

class UnitType < ActiveRecord::Base
end
