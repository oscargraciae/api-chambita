class AddPhotoToServiceImages < ActiveRecord::Migration
  def change
  	add_column :service_images, :photo, :text
  end
end
