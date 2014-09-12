ActiveAdmin.register Gallery do
  # has_many :photos

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  
  permit_params :name, :photos_attributes => [[:_destroy, :image, :position]] # , photos_attributes: [:image, :position] #, album_images_attributes: []

  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  # controller do
  #   #...
  #   def permitted_params
  #     params.permit(:name, :album_images_attributes => [])
  #   end
  # end
  show do
    panel "Gallery Details" do
      table_for gallery do
        column :id
        column :name
      end
    end
    panel "Gallery Images" do
      table_for gallery.photos do
        column :id
        column :image do |i|
          image_tag i.image.versions[:big_thumb].url
        end
        # ...
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.inputs "Photos" do
      f.has_many :photos, :allow_destroy => true, :heading => 'Photos', :new_record => true do |photo|
        # if photo.object.image.url != nil
        photo.input :_destroy, :as => :boolean, :required => false, :label => 'Delete image' if !photo.object.nil? && !photo.object.new_record? 

        if photo.object != nil and photo.object.image != nil and photo.object.image.url != nil
          photo.input :image, :hint => photo.template.image_tag(photo.object.image.versions[:big_thumb].url, :style => 'width: 100px;')
        else
          photo.input :image
        end
        # raw image_tag photo.object.image.versions[:big_thumb].url
        # end
      end
      # f.inputs :images do
      #   f.has_many_images :album_images
      # end
    end
    f.actions
  end

end
