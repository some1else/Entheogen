class Gallery < ActiveRecord::Base
  # has_many_images :album_images

  has_many :photos
  accepts_nested_attributes_for :photos, allow_destroy: true

  # def reject_photos(photo)
  #   photo.image.blank?
  # end
end
