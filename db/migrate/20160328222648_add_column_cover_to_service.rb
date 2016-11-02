class AddColumnCoverToService < ActiveRecord::Migration
  def up
    add_attachment :services, :cover
 end

  def down
    remove_attachment :services, :cover
  end
end
