class AddPackageIdToRequestService < ActiveRecord::Migration
  def change
    add_reference :request_services, :package, index: true, foreign_key: true
  end
end
