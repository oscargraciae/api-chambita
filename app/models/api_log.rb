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

class ApiLog < ActiveRecord::Base
end
