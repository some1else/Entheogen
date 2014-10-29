class AddPositionToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :position, :integer
  end
end
