class Photo < ActiveRecord::Base
  belongs_to :gallery
  acts_as_list scope: :gallery
  default_scope { order('position ASC') }

  mount_uploader :image, ImageUploader
end
