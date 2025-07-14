ActiveAdmin.register Subcategory do
  # Define o aninhamento com Category, usando o slug como chave de busca
  belongs_to :category, finder: :find_by_slug!, optional: true

  # Menu e permissões
  menu parent: "Categoria", priority: 2
  permit_params :name, :slug, :category_id, :banner, :sponsored,
                :headline_h1, :headline_h2, :headline_h3,
                :meta_title, :meta_description, :og_image

  # Pula a autorização do CanCanCan
  controller do
    skip_authorization_check

    # Busca pelo slug em vez do ID
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  # Filtros
  filter :category, as: :select, collection: -> { Category.pluck(:name, :id) }
  filter :name_cont, label: "Nome"
  filter :slug_cont, label: "Slug"

  # Index
  index title: "Subcategorias" do
    selectable_column
    id_column
    column :name
    column :slug
    # Exibe a categoria pai, com link para ela
    column :category do |sub|
      link_to sub.category.name, admin_category_path(sub.category)
    end
    column :created_at
    actions
  end

  # Formulário
  form do |f|
    f.inputs "Dados da Subcategoria" do
      # Garante que a categoria seja selecionada ou pré-selecionada
      f.input :category, as: :select, collection: Category.pluck(:name, :id), include_blank: false
      f.input :name
      # O slug é gerenciado pelo FriendlyId, mas pode ser editado
      f.input :slug
      f.input :banner, as: :file, hint: f.object.banner.attached? ? image_tag(f.object.banner.variant(resize_to_limit: [200, 200])) : content_tag(:span, "Nenhum banner")
      f.input :sponsored, label: "Patrocinado"
    end

    f.inputs "SEO & Headlines" do
      f.input :headline_h1
      f.input :headline_h2
      f.input :headline_h3
      f.input :meta_title
      f.input :meta_description
      f.input :og_image, as: :file, hint: (
        if f.object.og_image&.attached?
          image_tag(f.object.og_image.variant(resize_to_limit: [200, 200]))
        else
          content_tag(:span, "Nenhuma imagem OG")
        end
      )
    end
    f.actions
  end

  # Show
  show do
    attributes_table do
      row :name
      row :slug
      row :category
      row :sponsored
      row :banner do |sub| 
        image_tag(sub.banner, width: 400) if sub.banner.attached? 
      end
    end
  end
end
