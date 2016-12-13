# == Schema Information
#
# Table name: log_apis
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LogApi < ActiveRecord::Base
end
