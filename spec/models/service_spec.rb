# == Schema Information
#
# Table name: services
#
#  id                 :integer          not null, primary key
#  name               :string
#  description        :text
#  category_id        :integer
#  price              :decimal(8, 2)
#  is_fixed_price     :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  sub_category_id    :integer
#  published          :boolean
#  cover_file_name    :string
#  cover_content_type :string
#  cover_file_size    :integer
#  cover_updated_at   :datetime
#  rating_general     :decimal(8, 1)    default(0.0)
#  total_jobs         :integer          default(0)
#  isActive           :boolean          default(TRUE)
#  unit_type_id       :integer
#  unit_max           :integer
#  visits             :integer          default(0)
#

require 'rails_helper'

RSpec.describe Service, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
