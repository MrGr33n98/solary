SolarUser.destroy_all
SolarCompany.destroy_all
ReviewCampaign.destroy_all
SolarReview.destroy_all
SolarContent.destroy_all
Category.destroy_all
Badge.destroy_all

admin_user = SolarUser.create!(email: 'admin@solarenergy.com', name: 'Admin', password: 'password', password_confirmation: 'password', role: :admin)
moderator_user = SolarUser.create!(email: 'moderator@solarenergy.com', name: 'Moderator', password: 'password', password_confirmation: 'password', role: :moderator)
regular_user = SolarUser.create!(email: 'user@solarenergy.com', name: 'User', password: 'password', password_confirmation: 'password', role: :user)

# Update created_by_id and updated_by_id for initial users after they are created
admin_user.update_columns(created_by_id: admin_user.id, updated_by_id: admin_user.id)
moderator_user.update_columns(created_by_id: admin_user.id, updated_by_id: admin_user.id)
regular_user.update_columns(created_by_id: admin_user.id, updated_by_id: admin_user.id)

company = SolarCompany.create!(name: 'SolarCo 1', location: 'Location 1', installed_capacity_mw: 10.5, user_id: moderator_user.id, status: 'active', created_by_id: admin_user.id, updated_by_id: admin_user.id)
review_campaign = ReviewCampaign.create!(solar_company: company, user_id: moderator_user.id, title: 'Summer Campaign', start_date: DateTime.now, end_date: DateTime.now + 30.days, created_by_id: admin_user.id, updated_by_id: admin_user.id)
SolarReview.create!(solar_company: company, user_id: regular_user.id, rating: 4, comment: 'Great service', status: 'pending', review_campaign: review_campaign, created_by_id: admin_user.id, updated_by_id: admin_user.id)
category = Category.create!(name: 'Solar Guides')
SolarContent.create!(solar_company: company, user_id: moderator_user.id, title: 'Solar Guide', content_type: 'guide', body: 'Installation guide', category: category, created_by_id: admin_user.id, updated_by_id: admin_user.id)
Badge.create!(name: 'Top Contributor', description: 'For active users', badgeable: regular_user)