class Subcategory < ApplicationRecord
  belongs_to :category
  accepts_nested_attributes_for :category, allow_destroy: false

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one_attached :banner
  has_one_attached :og_image

  validates :name, presence: true, uniqueness: { scope: :category_id }
  validates :category, presence: true

  # Adiciona campos para SEO
  def meta_title
    name
  end

  def meta_description
    "Descubra tudo sobre #{name} na categoria #{category&.name || '...'}"
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name slug category_id sponsored]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
