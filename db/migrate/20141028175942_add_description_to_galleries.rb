class AddDescriptionToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :description, :text
  end
end
