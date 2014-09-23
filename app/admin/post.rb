ActiveAdmin.register Post do
  menu priority: 2, :label => "News"


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :body, "published_at(1i)", "published_at(2i)", "published_at(3i)", "published_at(4i)", "published_at(5i)"
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  form do |f|
    f.inputs "Details" do
      f.input :body, as: :wysihtml5, commands: [:bold, :italic, :underline, :ul, :ol, :outdent, :indent, :link, :image, :video], blocks: :barebone, height: :large
      f.input :published_at
    end
    f.actions
  end

end
