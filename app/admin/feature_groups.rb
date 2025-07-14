ActiveAdmin.register_page "Feature Groups" do
  menu priority: 11, label: "Feature Groups"
  controller do
    skip_authorization_check
  end
  content title: "Feature Groups" do
    para "A ser implementado."
  end
end