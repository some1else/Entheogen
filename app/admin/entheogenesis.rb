ActiveAdmin.register Entheogenesis do
  menu :label => "Entheogenesis", :priority => 10
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
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
      f.input :body, as: :wysihtml5, commands: [:bold, :italic, :underline, :ul, :ol, :outdent, :indent, :link], blocks: :barebone, height: :large
    end
    f.actions
  end

end
