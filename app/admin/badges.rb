ActiveAdmin.register Badge do
  menu priority: 5, label: "Badges"

  permit_params :name, :description, :badgeable_id, :badgeable_type, :seal

  controller do
    include CanCan::ControllerAdditions
    skip_authorization_check # Aplica para todas as ações do controller
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
    column :seal do |badge|
      image_tag(badge.seal.variant(resize_to_limit: [50, 50])) if badge.seal.attached?
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :badgeable_type, as: :select, collection: ['SolarCompany', 'SolarUser']
      f.input :badgeable_id
      f.input :seal, as: :file,
              hint: f.object.seal.attached? ?
                image_tag(f.object.seal.variant(resize_to_limit: [100, 100])) :
                content_tag(:span, "Nenhum selo carregado")
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :badgeable_type
      row :badgeable_id
      row :seal do |badge|
        image_tag(badge.seal.variant(resize_to_limit: [200, 200])) if badge.seal.attached?
      end
    end
  end
end
