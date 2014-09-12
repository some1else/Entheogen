class Gallery < ActiveRecord::Base
  has_many :photos
  accepts_nested_attributes_for :photos, reject_if: :reject_photos, allow_destroy: true

  def reject_photos(photo)
    photo.image.blank?
  end
end
