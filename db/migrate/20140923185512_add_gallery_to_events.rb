class AddGalleryToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :gallery, index: true
  end
end
