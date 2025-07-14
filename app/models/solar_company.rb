class SolarCompany < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associações de auditoria
  belongs_to :creator, class_name: "SolarUser", foreign_key: :created_by_id, optional: true
  belongs_to :updater, class_name: "SolarUser", foreign_key: :updated_by_id

  # Imagens
  has_one_attached  :logo
  has_one_attached  :cover_image
  has_one_attached  :banner_image
  has_many_attached :photos

  # Relações
  has_many :solar_reviews, dependent: :destroy
  # (outras associações…)

  # Enum de status
  enum status: { pending: "pending", active: "active", inactive: "inactive" }

  # Validações
  validates :name, :slug, :cnpj,
            :street_address, :city, :state,
            :contact_name, :contact_email,
            :installed_capacity_mwp,
            presence: true

  # Atualiza métricas após criar/atualizar
  after_commit :recalcular_metricas, on: [:create, :update]

  def recalcular_metricas
    update_columns(
      reviews_count: solar_reviews.count,
      avg_rating:    solar_reviews.average(:rating).to_f.round(2)
    )
  end

  def should_generate_new_friendly_id?
    name_changed? || slug.blank?
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name slug cnpj street_address city state postal_code latitude longitude contact_name contact_email contact_phone website facebook_url twitter_url linkedin_url installed_capacity_mwp commissioning_date module_technology module_brand module_count inverter_brand inverter_model avg_rating reviews_count total_energy_generated_mwh meta_title meta_description meta_keywords status created_by_id updated_by_id deleted_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[creator updater solar_reviews]
  end
end