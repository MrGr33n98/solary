ActiveAdmin.register Badge do
  menu priority: 5, label: "Badges"

  permit_params :name, :description, :badgeable_id, :badgeable_type

  controller do
    include CanCan::ControllerAdditions
    skip_authorization_check only: :index
  end

  filter :name_cont, label: 'Nome'
  filter :description_cont, label: 'Descrição'
  filter :badgeable_type, as: :select, collection: ['SolarCompany', 'SolarUser']
  filter :badgeable_id, label: 'ID Associado'

  index title: "Badges" do
    selectable_column
    id_column
    column :name
    column :description
    column :badgeable_type
    column :badgeable_id
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :badgeable_type, as: :select, collection: ['SolarCompany', 'SolarUser']
      f.input :badgeable_id
    end
    f.actions
  end
end