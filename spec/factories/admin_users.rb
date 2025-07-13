FactoryBot.define do
  factory :admin_user do
    email { "admin_#{SecureRandom.hex(4)}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end