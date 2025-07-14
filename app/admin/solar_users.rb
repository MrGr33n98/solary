ActiveAdmin.register SolarUser do
  permit_params :email, :name, :role, :status,
                :password, :password_confirmation,
                :created_by_id, :updated_by_id

  # Scopes
  scope :all,                     default: true,  label: -> { "Todas (#{SolarUser.count})" }
  scope :pending,                                label: -> { "Aguardando aprovação (#{SolarUser.pending.count})" }
  scope :approved,                               label: -> { "Aprovados (#{SolarUser.approved.count})" }
  scope :cancelled,                              label: -> { "Cancelados (#{SolarUser.cancelled.count})" }
  scope :awaiting_company_request,               label: -> { "Aguardando solicitar empresa (#{SolarUser.awaiting_company_request.count})" }
  scope :awaiting_product_request,               label: -> { "Aguardando solicitar produto (#{SolarUser.awaiting_product_request.count})" }
  scope :awaiting_product_approval,              label: -> { "Aguardando aprovar produto (#{SolarUser.awaiting_product_approval.count})" }
  scope :company_denied,                         label: -> { "Negado empresa (#{SolarUser.company_denied.count})" }
  scope :product_denied,                         label: -> { "Negado produto (#{SolarUser.product_denied.count})" }

  # Filtros laterais
  filter :email
  filter :role, as: :select, collection: SolarUser.roles.keys
  filter :name
  filter :status, as: :select, collection: SolarUser.statuses.keys

  # Index com botões customizados
  index download_links: [:csv, :xml, :json] do
    selectable_column
    id_column
    column :email
    column :name
    column :role
    column :status
    column :created_at
    actions defaults: true do |user|
      # só exibe quando estiver pendente
      if user.status == 'pending'
        link_to 'Approve', approve_admin_solar_user_path(user), method: :put, class: 'member_link'
      end
    end
  end

  # Ações de membro
  member_action :approve, method: :put do
    resource.update!(status: :approved)
    redirect_to admin_solar_users_path, notice: "Usuário aprovado!"
  end

  member_action :reject, method: :put do
    resource.update!(status: :cancelled)
    redirect_to admin_solar_users_path, alert: "Usuário reprovado!"
  end

  # Exemplo de outra ação de membro
  member_action :promote_to_admin, method: :put do
    resource.update!(role: :admin)
    redirect_to admin_solar_users_path, notice: "User promoted to admin successfully"
  end

  # Escopo de coleção customizado (exemplo de permissão)
  controller do
    skip_authorization_check
    def scoped_collection
      if current_admin_user&.solar_user&.admin?
        super
      else
        super.where(role: 'user')
      end
    end
  end

  # Formulário de edição/criação
  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :role, as: :select, collection: SolarUser.roles.keys
      f.input :password
      f.input :password_confirmation
      f.input :status, as: :select, collection: SolarUser.statuses.keys
      f.input :created_by_id, as: :select, collection: SolarUser.all.pluck(:email, :id)
      f.input :updated_by_id, as: :select, collection: SolarUser.all.pluck(:email, :id)
    end
    f.actions
  end
end
