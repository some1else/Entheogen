ActiveAdmin.register Photo do
  belongs_to :gallery

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model

  permit_params :image, :gallery_id, :position

  member_action :move_to_top, :method => :put do
    photo = Photo.find(params[:id])
    photo.move_to_top
    redirect_to admin_gallery_path(photo.gallery_id), {:notice => "Moved successfully."}
  end
  member_action :move_higher, :method => :put do
    photo = Photo.find(params[:id])
    photo.move_higher
    redirect_to admin_gallery_path(photo.gallery_id), {:notice => "Moved successfully."}
  end

  member_action :move_lower, :method => :put do
    photo = Photo.find(params[:id])
    photo.move_lower
    redirect_to admin_gallery_path(photo.gallery_id), {:notice => "Moved successfully."}
  end
  member_action :move_to_bottom, :method => :put do
    photo = Photo.find(params[:id])
    photo.move_to_bottom
    redirect_to admin_gallery_path(photo.gallery_id), {:notice => "Moved successfully."}
  end
  
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
