ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Company Dashboard"

  content do
    company = SolarCompany.find_by(id: 1) # Assuming you want to display details for a specific company, e.g., ID 1

    if company
      render partial: "dashboard", locals: { company: company }

      tabs do
        tab :metrics do
          render partial: "metrics", locals: { company: company }
        end
        tab :reviews do
          render partial: "reviews", locals: { reviews: company.solar_reviews.limit(5) }
        end
        tab :gallery do
          render partial: "projects_gallery", locals: { company: company }
        end
        tab :actions do
          render partial: "actions", locals: { company: company }
        end
        tab :plans do
          render partial: "plans", locals: { plans: Plan.all }
        end
        tab :solar_users do
          render partial: "solar_users", locals: { solar_users: SolarUser.all }
        end
        tab :saas_members do
          render partial: "saas_members", locals: { saas_members: SaasMember.all }
        end
        tab :saas_sponsored do
          render partial: "saas_sponsored", locals: { saas_sponsored_records: SaasSponsored.all }
        end
      end
    else
      div class: "blank_slate_container", id: "dashboard_default_message" do
        span class: "blank_slate" do
          span "Welcome to Active Admin. This is the default dashboard page."
          small "To add dashboard sections, checkout 'app/admin/dashboard.rb'"
        end
      end
    end
  end

  sidebar "Actions", only: :index do
        ul do
          li link_to "Manage Access", admin_saas_access_managements_path
        end
      end
end
