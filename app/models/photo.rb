class Photo < ActiveRecord::Base
  belongs_to :gallery
  acts_as_list scope: :gallery

  mount_uploader :image, ImageUploader
end
