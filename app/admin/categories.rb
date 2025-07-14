ActiveAdmin.register Category do
  menu priority: 7, label: "Categoria"

  permit_params :name, :sponsor_badge, :headline_h1, :headline_h2, :headline_h3, :meta_title, :meta_description, :og_image, :slug, :banner

  controller do
    include CanCan::ControllerAdditions
    skip_authorization_check # Aplica para todas as ações do controller

    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  filter :name_cont, label: 'Nome'
  filter :sponsor_badge_cont, label: 'Patrocinador'
  filter :slug_eq, label: 'Slug'

  index title: "Categoria" do
    selectable_column
    id_column
    column :name
    column :sponsor_badge
    column :headline_h1
    column "Banner" do |category|
      if category.banner.attached?
        image_tag category.banner.variant(resize_to_limit: [100, 100])
      else
        "N/A"
      end
    end
    column :solar_contents_count do |category|
      category.solar_contents.count
    end
    actions
  end

  form do |f|
    f.inputs "Dados Básicos" do
      f.input :name
      f.input :sponsor_badge
      f.input :slug # FriendlyId gerará automaticamente, mas pode ser editado
    end

    f.inputs "SEO & Copy" do
      f.input :headline_h1
      f.input :headline_h2
      f.input :headline_h3
      f.input :meta_title
      f.input :meta_description
      f.input :og_image
    end

    f.inputs "Banner" do
      f.input :banner, as: :file, hint: f.object.banner.present? ? image_tag(f.object.banner.variant(resize_to_limit: [200, 200])) : content_tag(:span, "Nenhuma imagem selecionada")
    end
    f.actions
  end

  show do
    # Injeta as meta tags no <head> da página, passando o host da requisição atual
    content_for :header do
      raw category.to_meta_tags(host: request.host_with_port)
    end

    panel "Banner" do
      if category.banner.attached?
        image_tag category.banner, style: "width: 100%;"
      else
        "Nenhum banner anexado"
      end
    end

    panel "Detalhes da Categoria" do
      attributes_table_for category do
        row :name
        row :sponsor_badge do |cat|
          if cat.sponsor_badge.present?
            span cat.sponsor_badge, class: "badge", style: "background-color: #f0ad4e; color: white; padding: 5px 10px; border-radius: 5px;"
          end
        end
        row :headline_h1 do |cat|
          h1 cat.headline_h1
        end
        row :headline_h2 do |cat|
          h2 cat.headline_h2
        end
        row :headline_h3 do |cat|
          h3 cat.headline_h3
        end
        row :slug
      end
    end

    panel "Conteúdo Relacionado" do
      table_for category.solar_contents do
        column :title
        column :status
        column :created_at
      end
    end

    active_admin_comments

    panel "Subcategorias" do
      table_for category.subcategories do
        column :id
        column :name
        column :created_at
        column do |sub|
          link_to "Ver", admin_subcategory_path(sub)
        end
      end
    end
  end
end