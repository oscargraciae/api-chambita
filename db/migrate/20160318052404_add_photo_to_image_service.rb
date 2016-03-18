class AddPhotoToImageService < ActiveRecord::Migration
  def up
    add_attachment :service_images, :photo
  end

  def down
    remove_attachment :service_images, :photo
  end
end
