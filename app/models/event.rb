class Event < ActiveRecord::Base
  before_validation :set_slug, on: :create
  validates :slug, uniqueness: true
  validates :title, :description, :slug, :date, presence: true

  def to_param
    slug
  end

  def time
    date.strftime('%l:%M%P').strip
  end

private

  def set_slug
    return unless date

    self.slug ||= (date.strftime('%B %Y ') + title).parameterize
  end
end