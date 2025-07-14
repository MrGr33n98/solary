ActiveAdmin.register Category do
  menu priority: 7, label: "Categoria"

  permit_params :name

  controller do
    include CanCan::ControllerAdditions
    skip_authorization_check only: :index
  end

  filter :name_cont, label: 'Nome'

  index title: "Categoria" do
    selectable_column
    id_column
    column :name
    column :solar_contents_count do |category|
      category.solar_contents.count
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end