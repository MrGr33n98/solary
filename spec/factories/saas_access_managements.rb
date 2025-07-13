FactoryBot.define do
  factory :saas_access_management do
    user { association :solar_user }
    access_level { "read" }
    status { "pending" }
    notes { "Test note" }
  end
end