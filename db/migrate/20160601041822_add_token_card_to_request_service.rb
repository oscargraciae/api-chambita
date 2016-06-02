class AddTokenCardToRequestService < ActiveRecord::Migration
  def change
    add_column :request_services, :token_card, :string
  end
end
