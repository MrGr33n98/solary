ActiveAdmin.register Feature do
  menu parent: "Configurações", priority: 1

  permit_params :name, :description, :active

  controller do
    skip_authorization_check
  end

  # Filtros válidos
  filter :name,        as: :string, label: 'Nome'
  filter :active,      as: :boolean, label: 'Ativa?'
  filter :created_at,  label: 'Criada em'

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :active
    actions
  end

  form do |f|
    f.inputs 'Dados da Feature' do
      f.input :name
      f.input :description
      f.input :active, as: :boolean, label: 'Ativa?'
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :active
      row :created_at
      row :updated_at
    end
  end
end
