class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one_attached :banner
  has_many :solar_contents, dependent: :nullify
  has_many :subcategories, dependent: :destroy
  accepts_nested_attributes_for :subcategories, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :headline_h1, presence: true
  validates :headline_h2, presence: true
  validates :headline_h3, presence: true
  validates :meta_title, presence: true
  validates :meta_description, presence: true

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def to_meta_tags(host: nil)
    host ||= Rails.application.routes.default_url_options[:host]
    unless host
      raise "Host para geração de URL não foi configurado. Verifique config/initializers/default_url_options.rb"
    end

    banner_url = banner.attached? ? Rails.application.routes.url_helpers.rails_blob_url(banner, host: host) : nil
    og_image_url = og_image.presence || banner_url
    category_full_url = Rails.application.routes.url_helpers.category_url(self, host: host)

    tags = <<-HTML
      <title>#{meta_title}</title>
      <meta name="description" content="#{meta_description}">
      <meta property="og:title" content="#{meta_title}">
      <meta property="og:description" content="#{meta_description}">
      <meta property="og:image" content="#{og_image_url}">
      <meta property="og:type" content="website">
      <meta property="og:url" content="#{category_full_url}">
      <script type="application/ld+json">
        {
          "@context": "http://schema.org",
          "@type": "WebPage",
          "name": "#{name}",
          "description": "#{meta_description}",
          "url": "#{category_full_url}"
        }
      </script>
    HTML
    tags.html_safe
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name sponsor_badge headline_h1 headline_h2 headline_h3 meta_title meta_description og_image slug]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['solar_contents', 'subcategories']
  end

  # Método finder para o ActiveAdmin usar o slug
  def self.find_by_slug!(slug)
    friendly.find(slug)
  end
end