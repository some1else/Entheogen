ActiveAdmin.register Gallery do
  # has_many :photos

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  
  permit_params :name

  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  form do |f|
    f.inputs do
      f.input :name
      f.has_many :photos, :allow_destroy => true, :heading => 'Photos', :new_record => true do |photo|
        photo.input :image
      end
    end
    f.actions
  end

end
