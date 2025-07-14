# SolarUser.destroy_all
# SolarCompany.destroy_all
# ReviewCampaign.destroy_all
# SolarReview.destroy_all
# SolarContent.destroy_all
# Category.destroy_all
# Badge.destroy_all

admin_user = SolarUser.find_or_create_by!(email: 'admin@solarenergy.com') do |user|
  user.name = 'Admin'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = :admin
end

moderator_user = SolarUser.find_or_create_by!(email: 'moderator@solarenergy.com') do |user|
  user.name = 'Moderator'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = :moderator
end

regular_user = SolarUser.find_or_create_by!(email: 'user@solarenergy.com') do |user|
  user.name = 'User'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = :user
end

# Create default admin user
SolarUser.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.name = 'Admin User'
  user.role = :admin
end

# Update created_by_id and updated_by_id for initial users after they are created
admin_user.update_columns(created_by_id: admin_user.id, updated_by_id: admin_user.id)
moderator_user.update_columns(created_by_id: admin_user.id, updated_by_id: admin_user.id)
regular_user.update_columns(created_by_id: admin_user.id, updated_by_id: admin_user.id)

company = SolarCompany.find_or_create_by!(name: 'SolarCo 1') do |c|
  c.location = 'Location 1'
  c.installed_capacity_mw = 10.5
  c.user_id = moderator_user.id
  c.status = 'active'
  c.created_by_id = admin_user.id
  c.updated_by_id = admin_user.id
end

review_campaign = ReviewCampaign.find_or_create_by!(solar_company: company, title: 'Summer Campaign') do |rc|
  rc.user_id = moderator_user.id
  rc.start_date = DateTime.now
  rc.end_date = DateTime.now + 30.days
  rc.created_by_id = admin_user.id
  rc.updated_by_id = admin_user.id
end

SolarReview.find_or_create_by!(solar_company: company, user_id: regular_user.id) do |sr|
  sr.rating = 4
  sr.comment = 'Great service'
  sr.status = 'pending'
  sr.review_campaign = review_campaign
  sr.created_by_id = admin_user.id
  sr.updated_by_id = admin_user.id
end

category = Category.find_or_create_by!(name: 'Solar Guides')

SolarContent.find_or_create_by!(solar_company: company, title: 'Solar Guide') do |sc|
  sc.user_id = moderator_user.id
  sc.content_type = 'guide'
  sc.body = 'Installation guide'
  sc.category = category
  sc.created_by_id = admin_user.id
  sc.updated_by_id = admin_user.id
end

Badge.find_or_create_by!(name: 'Top Contributor') do |b|
  b.description = 'For active users'
  b.badgeable = regular_user
end
