ActiveAdmin.register_page "FÓRUM - Perguntas" do
  controller do
    skip_authorization_check
  end
  menu priority: 9, label: "FÓRUM - Perguntas"
  content title: "FÓRUM - Perguntas" do
    para "A ser implementado."
  end
end