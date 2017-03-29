class AddDeclinedCardToRequestService < ActiveRecord::Migration
  def change
    add_column :request_services, :is_declined_card, :boolean, default: false
  end
end
