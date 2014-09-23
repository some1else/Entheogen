ActiveAdmin.register Event do

  menu priority: 2
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, "begins_at(1i)", "begins_at(2i)", "begins_at(3i)", "begins_at(4i)", "begins_at(5i)", :venue, :lineup, :fb_link, :gallery_id

  #
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
      f.input :venue
      f.input :lineup
      f.input :begins_at
      f.input :fb_link
      f.input :gallery
    end
    f.actions
  end


end
