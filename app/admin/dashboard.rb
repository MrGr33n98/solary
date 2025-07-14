ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Painel Administrativo"
  content title: "Painel Administrativo" do
    columns do
      column do
        panel "Estatísticas Gerais" do
          ul do
            li "Usuários: #{SolarUser.count}"
            li "Empresas Solares: #{SolarCompany.count}"
            li "Avaliações: #{SolarReview.count}"
          end
        end
      end
      column do
        panel "Últimas Avaliações" do
          table_for SolarReview.order(created_at: :desc).limit(5) do
            column :id
            column :solar_company do |review|
              link_to review.solar_company.name, admin_solar_company_path(review.solar_company)
            end
            column :rating
            column :status
          end
        end
      end
    end
  end
  controller do
    include CanCan::ControllerAdditions
    skip_authorization_check
  end
end