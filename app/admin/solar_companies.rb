ActiveAdmin.register SolarCompany do
  menu label: "Company Page"     # nome no menu lateral

  # 1. Permitir todos os campos de configuração
  permit_params :name,
                :slug,
                :logo,
                :title_h1,
                :title_h2,
                :banner_image,
                :show_breadcrumbs,
                :show_header,
                :show_search_reviews,
                :show_filter_by_rating,
                :show_sort_dropdown,
                :show_overall_rating,
                :show_rating_breakdown,
                :show_reviews_list,
                :show_pagination,
                :show_sidebar_top_companies,
                category_ids: []

  # 2. Expor resposta JSON para consumo no Next.js
  controller do
    respond_to :html, :json
    skip_authorization_check # Adicionado para evitar erros de autorização

    def find_resource
      scoped_collection.where(slug: params[:id]).first! || super
    end
  end

  filter :created_by_id,
         as: :select,
         collection: -> { SolarUser.order(:name).pluck(:name, :id) },
         label: 'Criado por'

  # 3. Index (lista resumida) com status dos flags
  index do
    selectable_column
    id_column
    column :name
    column :slug
    column("Header")     { |company| status_tag(company.show_header) }
    column("Banner")     { |company| status_tag(company.banner_image.attached?) }
    column("Reviews")    { |company| status_tag(company.show_reviews_list) }
    column :updated_at
    actions defaults: true do |company_record|
      link_to "JSON", admin_solar_company_path(company_record, format: :json)
    end
  end

  # 4. Formulário de criação/edição
  form(html: { multipart: true }) do |f|
    f.semantic_errors if f.object.errors.any?

    f.inputs "Identidade e Textos" do
      f.input :name,        label: "Nome da Empresa"
      f.input :slug,        label: "Slug (URL amigável)"
      f.input :logo,        as: :file, label: "Logo"
      f.input :title_h1,    label: "Título H1"
      f.input :title_h2,    label: "Título H2"
    end

    f.inputs "Banner" do
      f.input :banner_image,
              as: :file,
              hint: f.object.banner_image.attached? ?
                image_tag(f.object.banner_image.variant(resize_to_limit: [200,100])) :
                content_tag(:span, "Nenhum banner carregado"),
              label: "Banner (upload)"
    end

    f.inputs "Categorias" do
      f.input :categories,
              as: :check_boxes,
              collection: Category.all.map { |c| [c.name, c.id] },
              label: "Listar em categorias"
    end

    f.inputs "Controle de Componentes (Checkboxes)" do
      f.input :show_breadcrumbs,           as: :boolean, label: "Mostrar Breadcrumbs"
      f.input :show_header,                as: :boolean, label: "Mostrar Cabeçalho (logo + títulos)"
      f.input :show_search_reviews,        as: :boolean, label: "Mostrar caixa de busca de reviews"
      f.input :show_filter_by_rating,      as: :boolean, label: "Mostrar filtro por estrelas"
      f.input :show_sort_dropdown,         as: :boolean, label: "Mostrar dropdown de ordenação"
      f.input :show_overall_rating,        as: :boolean, label: "Mostrar nota geral"
      f.input :show_rating_breakdown,      as: :boolean, label: "Mostrar distribuição de notas"
      f.input :show_reviews_list,          as: :boolean, label: "Mostrar lista de reviews"
      f.input :show_pagination,            as: :boolean, label: "Mostrar paginação"
      f.input :show_sidebar_top_companies, as: :boolean, label: "Mostrar sidebar de top companies"
    end

    f.actions
  end

  # 5. Preview no Admin
  show do
    attributes_table do
      row :name
      row :slug
      row :logo_url
      row :title_h1
      row :title_h2
      row("Banner") do |c|
        image_tag url_for(c.banner_image) if c.banner_image.attached?
      end
      
      row("Breadcrumbs")          { status_tag(resource.show_breadcrumbs) }
      row("Header")               { status_tag(resource.show_header) }
      row("Busca de Reviews")     { status_tag(resource.show_search_reviews) }
      row("Filtro por Estrelas")  { status_tag(resource.show_filter_by_rating) }
      row("Ordenação")            { status_tag(resource.show_sort_dropdown) }
      row("Nota Geral")           { status_tag(resource.show_overall_rating) }
      row("Distribuição de Notas"){ status_tag(resource.show_rating_breakdown) }
      row("Lista de Reviews")     { status_tag(resource.show_reviews_list) }
      row("Paginação")            { status_tag(resource.show_pagination) }
      row("Sidebar Top Companies"){ status_tag(resource.show_sidebar_top_companies) }
    end
    active_admin_comments
  end
end
